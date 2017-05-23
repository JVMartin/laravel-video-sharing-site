@servers(['localhost' => '127.0.0.1'])

@setup
	$dir = dirname(__DIR__);
	$releasesPath = $dir . '/releases';
	$storagePath = $dir . '/storage';
	$envPath = $dir . '/.env';
	$currentLink = $dir . '/current';
	$release = date('YmdHis');
@endsetup

@story('deploy')
	git
	composer
	yarn
	links
	flushes
	optimizations
	switch
@endstory

@task('git')
	[ -d {{ $releasesPath }} ] || mkdir {{ $releasesPath }};
	cd {{ $releasesPath }};
	git clone seraph:/git/web/onemore.git {{ $release }};
@endtask

@task('composer')
	cd {{ $releasesPath }}/{{ $release }};
	composer install;
@endtask

@task('yarn')
	cd {{ $releasesPath }}/{{ $release }};
	yarn;
	yarn run prod;
@endtask

@task('links')
	{{-- Copy the storage folder if it doesn't exist yet. --}}
	if [ ! -d {{ $storagePath }} ]; then
		cp -r {{ $releasesPath }}/{{ $release }}/storage {{ $storagePath }};
	fi

	{{-- Copy the .env file if it doesn't exist .yet. --}}
	if [ ! -f {{ $envPath }} ]; then
		cp {{ $releasesPath }}/{{ $release }}/.env.example {{ $envPath }};
	fi

	rm -rf {{ $releasesPath }}/{{ $release }}/storage;
	ln -sfvT {{ $storagePath }} {{ $releasesPath }}/{{ $release }}/storage;
	ln -sfvT {{ $envPath }} {{ $releasesPath }}/{{ $release }}/.env;
	cd {{ $releasesPath }}/{{ $release }};
	php artisan storage:link;
@endtask

@task('flushes')
	cd {{ $releasesPath }}/{{ $release }};
	php artisan migrate --force;
	php artisan cache:clear;
@endtask

@task('optimizations')
	cd {{ $releasesPath }}/{{ $release }};
	php artisan optimize;

	{{-- This one doesn't work... --}}
	{{--php artisan config:cache;--}}

	php artisan route:cache;
@endtask

@task('switch')
	ln -sfvT {{ $releasesPath }}/{{ $release }} {{ $currentLink }};
	sudo systemctl reload php7.0-fpm.service;
	php artisan queue:restart;
@endtask
