<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTopicsTables extends Migration
{
	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('topics', function (Blueprint $table) {
			$table->increments('id');
			$table->string('topic_code');
			$table->string('slug');
			$table->string('name');
			$table->integer('count')->unsigned();
		});

		Schema::create('videos_topics', function (Blueprint $table) {
			$table->increments('id');
			$table->integer('topic_id')->unsigned();
			$table->integer('video_id')->unsigned();

			$table->index('topic_id');
			$table->index('video_id');

			$table->foreign('topic_id')
				->references('id')->on('topics')
				->onDelete('cascade');
			$table->foreign('video_id')
				->references('id')->on('videos')
				->onDelete('cascade');
		});
	}

	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::dropIfExists('videos_topics');
		Schema::dropIfExists('topics');
	}
}
