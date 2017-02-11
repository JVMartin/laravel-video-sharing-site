<?php

namespace App\Console\Commands;

use App\Services\VideoManager;
use Illuminate\Console\Command;

class GrabVideos extends Command
{
	/**
	 * The name and signature of the console command.
	 *
	 * @var string
	 */
	protected $signature = 'db:youtube';

	/**
	 * The console command description.
	 *
	 * @var string
	 */
	protected $description = 'Hit YouTube and grab a bunch of videos.';

	/**
	 * @var VideoManager
	 */
	protected $videoManager;

	public function __construct(VideoManager $videoManager)
	{
		$this->videoManager = $videoManager;

		parent::__construct();
	}

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
			'7xTOj6VwaVc', // World's worst hiker
			'UYG7FoneZZU', // More hiking
			'UNsIVfGptqM', // tutorialLinux
			'Gt_tUnf6T2E', // Philip DeFranco
			'KJC71dY13L8', // Anna Akana
			'qjYxXg4wZDg', // h3h3 pewdiepie
			'hbXDLKFkjm0', // Veritasium
			'j26ax_NDeek', // idubbbz visits tana mongeau
			'7jjTnvFAG0w', // Frat guy taking shots
			'uqWUfTsEEOE', // mr. steal your girl
			'IjpvhYpLVMo', // cutest dog in the world
			'wDc2aDH3zMM', // Chef Buck
			'RVMZxH1TIIQ', // Prison earth
			'kE1mKj8awyY', // lahwf
			'Q8ccXzM3x8A', // sixty symbols
			'keYYiuOJdrE', // nerdwriter scientology
			'9-5TSxd0ep0', // arcade fire
		];

		dd($youtube_ids);
	}
}
