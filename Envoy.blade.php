@servers(['localhost' => '127.0.0.1'])

@setup
	$var = 'Heyo!';
@endsetup

@task('deploy', ['on' => 'localhost'])
	echo {{ $var }}
@endtask
