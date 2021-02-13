<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\VideoFavorite;

class YoutubeController extends Controller
{
    public function getPopularsList()
    {
        $populars = \Youtube::getPopularVideos('id');
        $populars = array_map(function ($popular) {
            return [
                'id'                => $popular->id,
                'title'             => $popular->snippet->title,
                'description'       => $popular->snippet->description,
                'thumbnail_url'     => $popular->snippet->thumbnails->medium->url,
                'tags'              => array_slice($popular->snippet->tags ?? [], 0, 4),
            ];
        }, $populars);

        return response()->json([
            'status'        => true,
            'mesage'        => 'Mengambil list populer youtube',
            'data'          => [
                'populars'  => $populars
            ]
        ]);
    }
}