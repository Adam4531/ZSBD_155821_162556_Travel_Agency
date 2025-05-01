<?php

namespace App\Models\Oracle;

use Illuminate\Database\Eloquent\Model;

class Reservation extends Model
{
    protected $connection = 'oracle';
    protected $table = 'reservations';
    public $primaryKey = 'ID';
    protected $sequence   = 'RESERVATIONS_SEQ';
    public $timestamps = false;

    protected $fillable = [
        'user_id',
        'date_of_reservation',
        'amount_of_children',
        'amount_of_adults',
        'is_confirmed',
        'is_active',
    ];

    protected $casts = [
        'date_of_reservation' => 'date',
        'is_active' => 'boolean',
        'is_confirmed' => 'boolean',
    ];

    public function user(){
        return $this->belongsTo(User::class);
    }

    public static function getTableName()
    {
        return (new static)->getTable();
    }

}
