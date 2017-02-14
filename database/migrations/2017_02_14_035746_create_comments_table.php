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
			$table->text('contents');
			$table->timestamps();

			$table->foreign('submission_id')
				->references('id')->on('submissions')
				->onDelete('cascade');
			$table->foreign('parent_id')
				->references('id')->on('comments')
				->onDelete('cascade');
			$table->foreign('user_id')
				->references('id')->on('users');
		});
	}

	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::dropIfExists('comments');
	}
}
