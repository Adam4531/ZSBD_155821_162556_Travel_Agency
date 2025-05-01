<?php

namespace App\Models\Oracle;

use Illuminate\Database\Eloquent\Model;

class Tour extends Model
{
    protected $connection = 'oracle';
    protected $table = 'tours';

    protected $fillable = [
        'supervisor_id',
        'max_number_of_participants',
        'date_start',
        'date_end',
        'type_of_tour_id',
        'price_id',
        'country',
        'region',
        'city',
        'accommodation',
        'is_active',
    ];

    protected $casts = [
        'date_of_reservation' => 'date',
        'is_active' => 'boolean',
        'is_confirmed' => 'boolean',
    ];

    public function supervisor(){
        return $this->belongsTo(User::class, 'supervisor_id');
    }

    public function typeOfTour(){
        return $this->belongsTo(TourType::class, 'type_of_tour_id');
    }

    public function price(){
        return $this->belongsTo(Price::class, 'price_id');
    }

}
