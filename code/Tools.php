<?php

/**
*工具类，为方便使用，方法尽量声明为static类型
*/
class Tools {
	public static function httpPost($url, $post_data){
		try{
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_URL, $url);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt($ch, CURLOPT_POST, 1);
			curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post_data));
			$output = curl_exec($ch);
			curl_close($ch);
			return $output;
		}catch(Exception $e){
			return array();
		}
	}

	public static function httpGet($url){
		try{
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_URL, $url);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt($ch, CURLOPT_HEADER, 0);
			$output = curl_exec($ch);
			curl_close($ch);
			return $output;
		}catch(Exception $e){
			return array();
		}
	}


	public static function returnSuccessJson($msg='Request done',$data=array(),$append=array()){
		$result=array(
			"code" => 'success',
			'msg' => $msg,
			'data' => $data
		);

		if(!empty($append)){
			foreach ($append as $k => $v) {
				$result[$k]=$v;
			}
		}

		header('Content-type: application/json');
		exit(json_encode($result));
	}


	public static function returnErrorJson($msg='Request failed', $data=array()){
		$result=array(
			"code" => 'error',
			'msg' => $msg,
			'data' => $data
		);

		header('Content-type: application/json');
		exit(json_encode($result)) ;
	}

}