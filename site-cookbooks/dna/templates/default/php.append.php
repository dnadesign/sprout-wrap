<?php

if (extension_loaded('xhprof')) {
	if(isset($_REQUEST['_profile'])) {
		$profiler_namespace = strtolower(str_replace(array("/", ".", "\\"), "_", $_SERVER['DOCUMENT_ROOT']));
		$xhprof_data = xhprof_disable();
		$xhprof_runs = new XHProfRuns_Default();
	
		$run_id = $xhprof_runs->save_run($xhprof_data, $profiler_namespace);
	}
}