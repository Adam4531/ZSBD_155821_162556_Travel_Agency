<?php

namespace App\Models\Oracle;

use Illuminate\Database\Eloquent\Model;

class Price extends Model
{
    protected $connection = 'oracle';
    protected $table = 'price';

    protected $fillable = [
        'normal_price',
        'reduced_price',
        'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    public function tours(){
        return $this->hasMany(Tour::class);
    }
}
