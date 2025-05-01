<?php

namespace App\Console\Commands;

use App\Models\Oracle\Price;
use App\Models\Oracle\Reservation;
use App\Models\Oracle\Tour;
use App\Models\Oracle\TourHasReservation;
use App\Models\Oracle\TourType;
use App\Models\Oracle\User;
use App\Services\DatabaseService;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Log;

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
        $databaseService = new DatabaseService();

//        $priceModel = Price::class;
//        $databaseService->populateTableFromJsonFile($priceModel);
//        $this->info('populating ' . $priceModel);

        $tourTypeModel = TourType::class;
        $databaseService->populateTableFromJsonFile($tourTypeModel);
        $this->info('populating ' . $tourTypeModel);
//
//        $userModel = User::class;
//        $databaseService->populateTableFromJsonFile($userModel);
//        $this->info('populating ' . $userModel);
//
//        $reservationModel = Reservation::class;
//        $databaseService->populateTableFromJsonFile($reservationModel);
//        $this->info('populating ' . $reservationModel);
//
//        $tourModel = Tour::class;
//        $databaseService->populateTableFromJsonFile($tourModel);
//        $this->info('populating ' . $tourModel);
//
//        $tourHasReservationTable = TourHasReservation::class;
//        $databaseService->populateTableFromJsonFile($tourHasReservationTable);
//        $this->info('populating ' . $tourHasReservationTable);
    }
}
