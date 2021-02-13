<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VideoFavorite extends Model
{
    use HasFactory;
    protected $fillable = ['id', 'title', 'description', 'thumbnail_url', 'tags'];
    public $incrementing = false;
    protected $casts = [
        'tags'  => 'array'
    ];
}
