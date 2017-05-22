@servers(['localhost' => '127.0.0.1'])

@setup
	$dir = dirname(__DIR__);
	$releasesPath = $dir . '/releases';
	$storagePath = $dir . '/storage';
	$release = date('YmdHis');
@endsetup

@story('deploy')
	git
	composer
	yarn
	links
	switch
@endstory

@task('git')
	[ -d {{ $releasesPath }} ] || mkdir {{ $releasesPath }};
	cd {{ $releasesPath }};
	git clone seraph:/git/web/onemore.git {{ $release }};
@endtask

@task('composer')
	cd {{ $releasesPath }}/{{ $release }}
	composer install;
@endtask

@task('yarn')
	cd {{ $releasesPath }}/{{ $release }}
	yarn
	yarn run prod
@endtask

@task('links')
	{{-- Copy the storage folder if it doesn't exist yet. --}}
	if [ -d {{ $storagePath }} ]; then
		cp -r {{ $releasesPath }}/{{ $release }}/storage {{ $storagePath }}
	fi

	ln -sf {{ $storagePath }} {{ $releasesPath }}/{{ $release }}/storage
	cd {{ $releasesPath }}/{{ $release }}
	php artisan storage:link
@endtask
