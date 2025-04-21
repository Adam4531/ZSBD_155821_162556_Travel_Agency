<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote')->cron('* 18 * * *');

Schedule::command('sync:json-data-to-oracle-db')->cron('30 6 * * *');
