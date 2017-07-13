<?php

/**
*
*/
class DB2Master{
	private static $instance = null;
	private $db2 = null;

	private function __construct(){}
	private function __clone(){}

	public static function getInstance($dsn){
	    if(self::$instance === null){
	        self::$instance = new self;

	        require_once('MDB2.php');
	        $db = MDB2::factory($dsn);
	        if(MDB2::isError($db)){
	            die($db->getMessage());
	        }
	        self::$instance->db2 = $db;
	    }
	    return self::$instance;
	}

	public function insert($table, $set_str){
		$sql = "INSERT INTO {$table} SET {$set_str}";

		$res = $this->db->exec($sql);

		if(!$res){
			throw new Exception($this->db->errorInfo());
		}else{
			return $this->db->lastInsertId();
		}
	}

	public function update($table, $set_str, $where=''){
		$sql ="UPDATE {$table} SET {$set_str} ";
		if (!empty($where)) {
			$sql .= "WHERE $where ";
		}
		return $this->db->exec($sql);//返回受影响行数
	}



	public function __call($method,$parameters){
	    return call_user_func_array(array(self::$instance->db2, $method), $parameters);
	}

}

class DB2Slave {
	private static $instance = null;
	private $db2 = null;

	private function __construct(){}
	private function __clone(){}

	public static function getInstance($dsn){
	    if(self::$instance === null){
	        self::$instance = new self;

	        require_once('MDB2.php');
	        $db = MDB2::factory($dsn);
	        if(MDB2::isError($db)){
	            die($db->getMessage());
	        }
	        self::$instance->db2 = $db;
	    }
	    return self::$instance;
	}

	public function __call($method, $parameters){
	    return call_user_func_array(array(self::$instance->db2, $method), $parameters);
	}

}

class MysqlMaster{
	private static $instance = null;
	private $db = null;

	private function __construct(){}
	private function __clone(){}

	public static function getInstance($dsn){
	    if(self::$instance === null){
	        self::$instance = new self;
	        try{             
	        	$dsn_str="mysql:host={$dsn['host']};port={$dsn['port']};dbname={$dsn['dbname']}";                         
	        	$db_obj = new PDO($dsn_str, $dsn['user'], $dsn['password']);  
	        	if (!empty($dsn['names_encode'])) {
	        	    $db_obj->query("set names {$dsn['names_encode']}");
	        	}       
	        }catch(Exception $exception){
	          	die( $exception->getMessage() );
	        }
	        self::$instance->db = $db_obj;
	    }
	    return self::$instance;
	}



	public function insert($table, $set_str){
		$sql = "INSERT INTO {$table} SET {$set_str}";

		$res = $this->db->exec($sql);

		if(!$res){
			throw new Exception($this->db->errorInfo());
		}else{
			return $this->db->lastInsertId();
		}
	}

	public function update($table, $set_str, $where=''){
		$sql ="UPDATE {$table} SET {$set_str} ";
		if (!empty($where)) {
			$sql .= "WHERE $where ";
		}
		return $this->db->exec($sql);//返回受影响行数
	}


	public function __call($method,$parameters){
	    return call_user_func_array(array(self::$instance->db, $method), $parameters);
	}

}

class MysqlSlave {
	private static $instance = null;
	private $db = null;

	private function __construct(){}
	private function __clone(){}

	public static function getInstance($dsn){
	    if(self::$instance === null){
	        self::$instance = new self;
	        try{             
	        	$dsn_str="mysql:host={$dsn['host']};port={$dsn['port']};dbname={$dsn['dbname']}";                         
	        	$db_obj = new PDO($dsn_str, $dsn['user'], $dsn['password']);  
	        	if (!empty($dsn['names_encode'])) {
	        	    $db_obj->query("set names {$dsn['names_encode']}");
	        	}       
	        }catch(Exception $exception){
	          	die( $exception->getMessage() );
	        }
	        self::$instance->db = $db_obj;
	    }
	    return self::$instance;
	}


	public function query($selector, $table, $where='', $limit='', $orderby=''){
		$sql = "SELECT $selector FROM $table ";
		if (!empty($where)) {
			$sql .= "WHERE $where ";
		}
		if (!empty($orderby)) {
			$sql .= "ORDER BY $orderby  ";
		}
		if (!empty($limit)) {
			$sql .= "LIMIT $limit ";
		}

		$ret = $this->db->prepare($sql);
		if(empty($ret)){
			throw new Exception($this->db->errorInfo());
		}


		$ret->execute();
		$dataList = $ret->fetchAll(PDO::FETCH_ASSOC);
		
		return $dataList;
	}

	public function queryOne($selector, $table, $where){
		$data = $this->query($selector, $table, $where, '1');
		return empty($data) ? array() : $data[0];
	}


	public function __call($method, $parameters){
	    return call_user_func_array(array(self::$instance->db, $method), $parameters);
	}

}

/**
*
*/
class DBManager{

	private function __construct(){}
	private function __clone(){}


	public static  function getWriteInstance($driver='db2', $config=null){
		if ($driver == 'db2') {
			if (empty($config)) {
				return DB2Master::getInstance(array(
				    'phptype'  => "mysql",
				    'username' => $_SERVER['SINASRV_DB3_USER'],
				    'password' => $_SERVER['SINASRV_DB3_PASS'],
				    'hostspec' => $_SERVER['SINASRV_DB3_HOST'],
				    'port'     => $_SERVER['SINASRV_DB3_PORT'],
				    'database' => $_SERVER['SINASRV_DB3_NAME'],
				));
			}else{
				return DB2Master::getInstance(array(
				    'phptype'  => "mysql",
				    'username' => $config['user'],
				    'password' => $config['password'],
				    'hostspec' => $config['host'],
				    'port'     => $config['port'],
				    'database' => $config['dbname'],
				));
			}
			
		}elseif ($driver=='mysql') {//
			if (empty($config)) {
				return MysqlMaster::getInstance(array(
				    'host'=>DB_HOST,
				    'port'=>DB_PORT,
				    'dbname'=>DB_NAME,
				    'user'=>DB_USER,
				    'password'=>DB_PW,
				    'names_encode'=> DB_ENCODE
				));
			}else{
				return MysqlMaster::getInstance(array(
				    'host'=>$config['host'],
				    'port'=>$config['port'],
				    'dbname'=>$config['dbname'],
				    'user'=> $config['user'],
				    'password'=>$config['password'],
				    'names_encode'=> $config['encode']
				));
			}
			
		}
	}


	public static  function getReadInstance($driver='db2', $config=null){
		if ($driver == 'db2') {
			if (empty($config)) {
				return DB2Slave::getInstance(array(
				    'phptype'  => "mysql",
				    'username' => $_SERVER['SINASRV_DB3_USER_R'],
				    'password' => $_SERVER['SINASRV_DB3_PASS_R'],
				    'hostspec' => $_SERVER['SINASRV_DB3_HOST_R'],
				    'port'     => $_SERVER['SINASRV_DB3_PORT_R'],
				    'database' => $_SERVER['SINASRV_DB3_NAME_R'],
				));
			}else{
				return DB2Slave::getInstance(array(
				    'phptype'  => "mysql",
				    'username' => $config['user'],
				    'password' => $config['password'],
				    'hostspec' => $config['host'],
				    'port'     => $config['port'],
				    'database' => $config['dbname'],
				));
			}
		    
	    }elseif ($driver=='mysql') {//
	    	if (empty($config)) {
	    		return MysqlSlave::getInstance(array(
	    		    'host'=>DB_HOST,
				    'port'=>DB_PORT,
				    'dbname'=>DB_NAME,
				    'user'=>DB_USER,
				    'password'=>DB_PW,
				    'names_encode'=> DB_ENCODE
	    		));
	    	}else{
	    		return MysqlMaster::getInstance(array(
	    		    'host'=>$config['host'],
	    		    'port'=>$config['port'],
	    		    'dbname'=>$config['dbname'],
	    		    'user'=> $config['user'],
	    		    'password'=>$config['password'],
	    		    'names_encode'=> $config['encode']
	    		));
	    	}
	    }
	}
}