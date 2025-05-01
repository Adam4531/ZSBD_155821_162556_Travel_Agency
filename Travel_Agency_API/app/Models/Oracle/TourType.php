<?php

namespace App\Models\Oracle;

use Illuminate\Database\Eloquent\Model;

class TourType extends Model
{
    protected $connection = 'oracle';
    protected $table = 'types_of_tour';

    protected $fillable = [
        'name_of_tour',
        'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    public function tours(){
        return $this->hasMany(Tour::class);
    }
}
