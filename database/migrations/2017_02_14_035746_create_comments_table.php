<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCommentsTable extends Migration
{
	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('comments', function (Blueprint $table) {
			$table->increments('id');
			$table->integer('submission_id')->unsigned();
			$table->integer('parent_id')->unsigned()->nullable();
			$table->integer('user_id')->unsigned()->nullable();
			$table->boolean('deleted')->default(false);
			$table->text('contents');
			$table->integer('score')->default(1);
			$table->integer('num_up')->unsigned()->default(1);
			$table->integer('num_down')->unsigned()->default(0);
			$table->integer('num_replies')->unsigned()->default(0);
			$table->timestamps();

			$table->index('submission_id');
			$table->index('user_id');

			$table->foreign('submission_id')
				->references('id')->on('submissions')
				->onDelete('cascade');
			$table->foreign('parent_id')
				->references('id')->on('comments');
			$table->foreign('user_id')
				->references('id')->on('users');
		});

		Schema::create('comments_votes', function (Blueprint $table) {
			$table->increments('id');
			$table->integer('comment_id')->unsigned();
			$table->integer('user_id')->unsigned();
			$table->tinyInteger('up')->unsigned()->default(0);
			$table->tinyInteger('down')->unsigned()->default(0);

			$table->index('comment_id');
			$table->index('user_id');

			$table->foreign('comment_id')
				->references('id')->on('comments')
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
		Schema::dropIfExists('comments_votes');
		Schema::dropIfExists('comments');
	}
}
