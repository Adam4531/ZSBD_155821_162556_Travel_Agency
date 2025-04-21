<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class SyncJsonDataToOracleDB extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'sync:json-data-to-oracle-db';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Sync oracle db with json data';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        //TODO provide populate (create or update on conflict) using service
    }
}
