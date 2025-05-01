<?php

namespace App\Models\Oracle;

use Illuminate\Database\Eloquent\Model;

class TourHasReservation extends Model
{
    protected $connection = 'oracle';
    protected $table = 'tour_has_reservations';

    protected $fillable = [
        'reservation_id',
        'tour_id',
        'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    public function tour(){
        return $this->belongsTo(Tour::class);
    }

    public function reservation(){
        return $this->belongsTo(Reservation::class);
    }
}
