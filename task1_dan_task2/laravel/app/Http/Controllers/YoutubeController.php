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

    /**
     * Dapatkan data untu k chart video populer
     *
     * @return Response object
     */
    public function getPopularsChart()
    {
        $populars = \Youtube::getPopularVideos('id');
        $populars = array_map(function ($popular) {
            return [
                'title'             => $popular->snippet->title,
                'view'              => $popular->statistics->viewCount,
                'like'              => $popular->statistics->likeCount,
                'dislike'              => $popular->statistics->dislikeCount,
                'comment'              => $popular->statistics->commentCount,
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
