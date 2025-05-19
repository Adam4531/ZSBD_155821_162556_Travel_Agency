<?php

namespace App\Services;

use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Log;

class DatabaseService
{

    public function populateTableFromJsonFile($model, $uniqueKey = 'ID', $path = null){
        $tableName = $model::getTableName();
        $path = $path == null ? database_path('data/'. $tableName . '.json') : $path;

        if(!file_exists($path)){
            Log::error("JSON file does not exist in: " . $path);
            return 1;
        }

        $data = json_decode(file_get_contents($path), true)[$tableName];
        if(json_last_error() !== JSON_ERROR_NONE){
            Log::error("Issue occured while decoding file: " . json_last_error_msg());
            return 1;
        }
        foreach ($data as $item) {

            $filteredItem = !empty($parent_field)
                ? Arr::except($item, [$parent_field])
                : $item;

            try{
                $model::updateOrCreate([$uniqueKey => $uniqueKey], $filteredItem);
            } catch (\Exception $e){
                Log::error('Error while populating data of model: '. $model .' with json file, error message: ' . $e->getMessage());
            }
        }
    }

}
