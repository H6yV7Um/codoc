<?php

require_once(INCLUDE_DIR.'/DBManager.php');
require_once(INCLUDE_DIR.'/SmartyMgr.php');

/**
* 
*/
class Application
{

	public $mdb = null;
	public $sdb = null;
	public $view = null;
	public $userinfo=null;
	
	function __construct()
	{
		$this->mdb =  DBManager::getWriteInstance(DB_DRIVER);
		$this->sdb =  DBManager::getReadInstance(DB_DRIVER);
		$this->view = SmartyMgr::getSmarty();
		$this->userinfo=array(
			'wbname'=>'testZXG',
			'email'=>'xiangguang@staff.weibo.com'
		);
	}


	public function assign($name, $val){
		$this->view->assign($name, $val);
	}

	public function display($tmp_name){
		$this->view->display($tmp_name);
	}


	public function query($selector, $table, $where='', $limit='', $orderby=''){
		return $this->sdb->query($selector, $table, $where, $limit, $orderby);
	}


	function queryOne($selector, $table, $where){
		return $this->sdb->queryOne($selector, $table, $where);
	}

}