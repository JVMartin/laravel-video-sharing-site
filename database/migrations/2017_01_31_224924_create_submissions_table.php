<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSubmissionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
		Schema::create('submissions', function (Blueprint $table) {
			$table->increments('id');
			$table->integer('video_id')->unsigned();
			$table->integer('user_id')->unsigned();
			$table->string('title');
			$table->string('slug');
			$table->text('description')->nullable();
			$table->integer('score')->default(1);
			$table->integer('num_up')->unsigned()->default(1);
			$table->integer('num_down')->unsigned()->default(0);
			$table->integer('num_comments')->unsigned()->default(0);
			$table->timestamps();

			$table->foreign('video_id')
				->references('id')->on('videos')
				->onDelete('cascade');
			$table->foreign('user_id')
				->references('id')->on('users')
				->onDelete('cascade');
		});

		Schema::create('submissions_votes', function (Blueprint $table) {
			$table->increments('id');
			$table->integer('submission_id')->unsigned();
			$table->integer('user_id')->unsigned();
			$table->tinyInteger('up')->unsigned()->default(0);
			$table->tinyInteger('down')->unsigned()->default(0);

			$table->index('submission_id');
			$table->index('user_id');

			$table->foreign('submission_id')
				->references('id')->on('submissions')
				->onDelete('cascade');
			$table->foreign('user_id')
				->references('id')->on('users')
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
        Schema::dropIfExists('submissions_votes');
        Schema::dropIfExists('submissions');
    }
}
