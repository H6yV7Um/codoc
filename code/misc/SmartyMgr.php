<?php

/**
*
*/
class SmartyWrapper{
	private static $instance = null;
	private $smarty = null;

	private function __construct(){}
	private function __clone(){}

	public static function getInstance($config){
	    if(self::$instance === null && !empty($config)){
	        self::$instance = new self;

	        include_once(SMARTY_DIR.'/Smarty.class.php');
	        $smty = new Smarty();  
	        $smty->config_dir=$config['config_dir'];// 
	        $smty->caching=$config['caching']; //是否使用模版缓存，超大时1  
	        $smty->cache_lifetime=$config['cache_lifetime'];//缓存时间，tim秒；   
	        $smty->template_dir = $config['template_dir']; //设置模板目录
	        $smty->compile_dir = $config['compile_dir']; //设置编译目录   
	        $smty->cache_dir = $config['cache_dir']; //缓存文件夹
	        if(!is_dir($smty->cache_dir)){
	        	mkdir($smty->cache_dir);
	        }
	        $smty->left_delimiter = "([";   //定义左边   
	        $smty->right_delimiter = "])"; //定义右边  

	        
	        self::$instance->smarty = $smty;
	    }
	    return self::$instance;
	}

	public function assign($name, $val){
		$this->smarty->assign($name, $val);
	}

	public function display($tmp_name){
		header('Content-Type: text/html; charset=UTF-8');
		header("Expires:Mon,26Jul199705:00:00GMT");
		header("Cache-Control:no-cache,must-revalidate");
		header("Pragma:no-cache");

		$this->smarty->display($tmp_name);
	}


	public function __call($method,$parameters){
	    return call_user_func_array(array(self::$instance->smarty, $method), $parameters);
	}

}


/**
*
*/
class SmartyMgr{

	private function __construct(){}
	private function __clone(){}

	public static  function getSmarty($config=''){
		if (empty($config)) {
			$config['config_dir']='Smarty/Config_File.class.php';// 
			$config['caching']=0;//是否使用模版缓存，超大时1  
			$config['cache_lifetime']=0;//缓存时间，tim秒；   
			$config['template_dir']=TEMPLATE_DIR; //设置模板目录
			if (!empty($_SERVER['SINASRV_CACHE_DIR'])) {
				$config['compile_dir'] = $_SERVER['SINASRV_CACHE_DIR'].$projectname."/";
				$config['cache_dir'] = $_SERVER['SINASRV_CACHE_DIR'].$projectname."/"; 
			}else{
				$config['compile_dir'] = SMARTY_CACHE_DIR; //设置编译目录   
				$config['cache_dir'] = SMARTY_CACHE_DIR; //缓存文件夹
			}
		}
		

		return SmartyWrapper::getInstance($config);
	}
}