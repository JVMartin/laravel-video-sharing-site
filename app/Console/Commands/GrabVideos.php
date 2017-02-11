<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class GrabVideos extends Command
{
	/**
	 * The name and signature of the console command.
	 *
	 * @var string
	 */
	protected $signature = 'db:videos';

	/**
	 * The console command description.
	 *
	 * @var string
	 */
	protected $description = 'Hit YouTube and grab a bunch of videos.';

	/**
	 * Execute the console command.
	 *
	 * @return mixed
	 */
	public function handle()
	{
		$youtube_ids = [
			'qrO4YZeyl0I', // Bad Romance
			'eQZEQQMWiVs', // Scotty Cranmer
			'uuIlvSNU67o', // Adam LZ
			'UZPCp8SPfOM', // Joe Rogan
			'P8a4iiOnzsc', // Radical Face
			'QVQK_Yp0KuI', // Reggie Watts
			'mulGqCjMzCs', // Cherdleys
			'-X_aCfVhWYI', // PCT
			'trteo6m23oA', // Millionaire's shop tour
			'Hu64xbgprWY', // Universe (board of canada)
			'', //
			'', //
			'', //
			'', //
		];
	}
}
