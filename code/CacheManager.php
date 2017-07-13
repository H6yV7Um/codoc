<?php

class RedisMaster {
    private static $instance = null;
    private $masterList = array();

    private function __construct(){}
    private function __clone(){}

    //使用的时候一定要检查是否返回有效的实例
    public static function getInstance($masterConfigs){
        if(self::$instance === null || !empty($masterConfigs)){
            $has_valid=false;
            $masters=array();
            foreach ($masterConfigs as $conf) {
                $redis=null;
                try {
                    $redis = new Redis();
                    $redis->connect($conf['host'], $conf['port']);
                    if (isset($conf['password']) && !empty($conf['password'])) {
                        $redis->auth($conf['password']);
                    }
                } catch (Exception $e) {
                    $redis=null;
                }

                if ($redis) {
                    $has_valid=true;
                    $masters[]=$redis;
                }

            }
            if ($has_valid) {
                self::$instance = new self;
                self::$instance->masterList = $masters;
            }

        }
        return self::$instance;
    }

    public function __call($method,$parameters){
        return call_user_func_array(array(self::$instance->masterList[0], $method), $parameters);
    }
}


class RedisSlave {
    private static $instance = null;
    private $slaveList = array();

    private function __construct(){}
    private function __clone(){}

    //使用的时候一定要检查是否返回有效的实例
    public static function getInstance($slaveConfigs){
        if(self::$instance === null || !empty($masterConfigs)){
            $has_valid=false;
            $slaves=array();
            foreach ($slaveConfigs as $conf) {
                $redis=null;
                try {
                    $redis = new Redis();
                    $redis->connect($conf['host'], $conf['port']);
                    if (!empty($conf['password'])) {
                        $redis->auth($conf['password']);
                    }
                } catch (Exception $e) {
                    $redis=null;
                }

                if ($redis) {
                    $has_valid=true;
                    $slaves[]=$redis;
                }

            }
            if ($has_valid) {
                self::$instance = new self;
                self::$instance->slaveList = $slaves;
            }

        }
        return self::$instance;
    }

    public function __call($method,$parameters){
        return call_user_func_array(array(self::$instance->slaveList[0], $method), $parameters);
    }
}


interface Builder {
    public function  build($config);
}

class RedisBuilder implements Builder{

    public function  build($config){
    }

}

class CacheManager{
    private static $config=array(
        'redis'=>array(
            'enabled'=>REDIS_ENABLE,
            'master'=>array(
                array(
                    'host' => 'rm20652.eos.grid.sina.com.cn',
                    'password' => '',
                    'port' => 20652,
                )
            ),
            'slave'=>array(
                array(
                    'host' => 'rs20652.hebe.grid.sina.com.cn',
                    'password' => '',
                    'port' => 20652,
                )
            )
        ),
        'other'=>array()
    );

    private function __construct(){}
    private function __clone(){}

    private static function getRedis($name='slave'){
        $redisConf = @self::$config['redis'][$name];
        if( !self::$config['redis']['enabled'] || empty($redisConf) ){
            return null;
        }

        if ($name ==='slave') {
            return RedisSlave::getInstance($redisConf);
        }elseif ($name === 'master') {
            return RedisMaster::getInstance($redisConf);
        }

        return null;
    }

    public static  function getRedisMaster(){
        return self::getRedis('master');
    }



    public static  function getRedisSlave(){
        return self::getRedis('slave');
    }


    //根据查询的分页数进行简单的缓存时长控制
    public static function getCacheExpire($tableStr, $limitStr=''){
        // limitStr形如：limit 30,10
        $offset = preg_match('/([0-9]{1,})/',$limitStr,$m) ? $m[1] : 0;

        if($offset < 60){//读前60条数据，缓存30分钟
            $expire=1800;
        }elseif($offset < 120){//读60~120条数据，缓存10分钟
            $expire=600;
        }else{
            $expire=300;//默认缓存时间5分钟
        }
        return $expire;
    }

    public static function deleteFromRedis($key_prefix){

        $set_key = $key_prefix.':str:keys';
        $master = self::getRedisMaster();

        //将半个时前的key删除掉
        $curtime = time();
        $bytime = $curtime - 60*31;
        $master->zremrangebyscore($set_key, 0, $bytime);


        $keys = $master->zrangebyscore($set_key, $bytime, $curtime);

        $count=0;
        foreach ($keys as $k) {
            $count++;
            $master->del($k);
            $master->zrem($set_key, $k);
        }
        echo "$count keys deleted! <br>";
    }
}

