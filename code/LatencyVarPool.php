<?php
/**
*  这个类主要用于保存和读取，那些延迟使用的变量
*  诸如：从分享出去的链接或扫二维码等方式进入系统的页面带了些url参数
*  如代理商主页的agent_id，垂直行业的industry_id，以及链接来源alk_from
*  这些参数并不是用户第一次访问页面就马上使用的变量，常常是用户进入系统后去浏览
*  很多其他页面，然后才进入相关功能模块并会最终使用到此类变量
*/
class LatencyVarPool
{

	public static function save($name, $value){
		setcookie('latency_'.$name, $value, 0, '/');
	}

	public static function get($name){
		$name = 'latency_'.$name;
		return isset($_COOKIE[$name]) ? $_COOKIE[$name] : '';
	}

	//从请求参数中直接保存到cookie
	public static function saveFromRequest($name){
		if (is_array($name)) {
			foreach ($name as $n) {
				$value='';
				//只有cookie中未设置相应变量时，才往cookie里写
				$old_val=self::get($n);
				if ( empty($old_val) && isset($_REQUEST[$n]) && !empty($_REQUEST[$n]) ) {
				    $value = $_REQUEST[$n];
				}
				if (!empty($value)) {
					self::save($n, $value);
				}
			}
		}else{
			$value='';
			$old_val=self::get($n);
			if ( empty($old_val) && isset($_REQUEST[$name]) && !empty($_REQUEST[$name]) ) {
			    $value = $_REQUEST[$name];
			}
			if (!empty($value)) {
				self::save($name, $value);
			}
		}
	}

	//优先人请求的参数中读取，读不到再从cookie中读
	public static function getFirstRequestThenPool($name){
		if (isset($_REQUEST[$name]) && !empty($_REQUEST[$name])) {
			return $_REQUEST[$name];
		}else{
			return self::get($name);
		}
	}
}