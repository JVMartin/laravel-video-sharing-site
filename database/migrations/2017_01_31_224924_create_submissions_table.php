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
			$table->char('youtube_id', 11);
			$table->string('title');
			$table->text('description');
			$table->timestamps();

			$table->foreign('youtube_id')
				->references('youtube_id')->on('videos')
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
        Schema::dropIfExists('submissions');
    }
}
