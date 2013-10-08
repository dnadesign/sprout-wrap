<?php

/**
 * File which is automatically included after every PHP request by definition
 * of the apache virtual host configuration.
 *
 * If you particular application needs to set auto_append_file then it should
 * be included here.
 */

// fix the doc root for virtual hosts
require_once(dirname(__FILE__) . '/setdocroot.php');

// include XHProf helper
if (extension_loaded('xhprof')) {
	include_once '/usr/local/opt/php54-xhprof/xhprof_lib/utils/xhprof_lib.php';
	include_once '/usr/local/opt/php54-xhprof/xhprof_lib/utils/xhprof_runs.php';
	
	if(isset($_REQUEST['_profile'])) {
		xhprof_enable(XHPROF_FLAGS_CPU + XHPROF_FLAGS_MEMORY);
	}
}