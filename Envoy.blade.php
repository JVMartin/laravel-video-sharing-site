@servers(['localhost' => '127.0.0.1'])

@setup
	$dir = dirname(__DIR__);
	$release = date('YmdHis');
@endsetup

@story('deploy')
	git
@endstory

@task('git')
	echo "{{ $dir }}";
@endtask
