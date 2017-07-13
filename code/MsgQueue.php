<?php
/**
 * Created by PhpStorm.
 * User: liangpei
 * Date: 2017/2/9
 * Time: 18:36
 */

interface MsgQueue{
    public static function getInstance();
    public function enqueue($data);
    public function dequeue();
}

class MCQClient implements MsgQueue{
    private static $instance;
    private $mcq;

    private function   __construct(){}
    private function __clone(){}

    public static function getInstance(){
        if(empty(self::$instance)){
            $mc = new Memcache;
            if($mc->addServer('mcq13660.yf.dspqueue.sina.com.cn', 13660)
                && $mc->addServer('mcq13660.bx.dspqueue.sina.com.cn', 13660)){
                self::$instance = new self;
                self::$instance->mcq = $mc;
            }
        }
        return self::$instance;
    }

    public function enqueue($data){
        return self::$instance->mcq->set('WBCSC',$data);
    }

    public function dequeue(){
        return self::$instance->mcq->get('WBCSC#1');
    }
}

class MsgQueueManager{
    private function   __construct(){}
    private function __clone(){}

    public static function getMQClient($type='MCQ'){
        if($type==='MCQ'){
            return MCQClient::getInstance();
        }
        return null;
    }

}