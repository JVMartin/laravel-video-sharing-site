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
			$table->integer('score')->default(1);
			$table->integer('num_up')->default(1);
			$table->integer('num_down')->default(0);
			$table->integer('num_replies')->default(0);
			$table->boolean('deleted')->default(false);
			$table->text('contents');
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
			$table->integer('user_id')->unsigned()->nullable();
			$table->boolean('up')->default(false);
			$table->boolean('down')->default(false);

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
		Schema::dropIfExists('comments_ratings');
		Schema::dropIfExists('comments');
	}
}
