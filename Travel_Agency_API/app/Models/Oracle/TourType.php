<?php

namespace App\Models\Oracle;

use Illuminate\Database\Eloquent\Model;

class TourType extends Model
{
    protected $connection = 'oracle';
    protected $table = 'types_of_tour';
    public $primaryKey = 'ID';
    protected $sequence = 'TYPES_OF_TOUR_SEQ';
    public $timestamps = false;

    protected $fillable = [
        'name_of_type',
        'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    public function tours(){
        return $this->hasMany(Tour::class);
    }

    public static function getTableName()
    {
        return (new static)->getTable();
    }

}
