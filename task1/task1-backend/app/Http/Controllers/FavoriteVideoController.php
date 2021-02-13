<?php

namespace App\Http\Controllers;

use App\Models\VideoFavorite;
use Illuminate\Http\Request;

class FavoriteVideoController extends Controller
{
    public function list()
    {
        $lists = VideoFavorite::all();
        return response()->json([
            'status'        => true,
            'mesage'        => 'Mengambil list video favorite',
            'data'          => [
                'favorites'  => $lists
            ]
        ]);
    }

    public function check($id)
    {
        return VideoFavorite::find($id) ? true : false;
    }
    public function toggle(Request $request)
    {
        $request->validate([
            'id'        => 'required'
        ]);

        try {
            $check = VideoFavorite::find($request->id);
            if ($check) {
                $check->delete();
            } else {
                VideoFavorite::create($request->all());
            }

            return response()->json([
                'status'        => true,
                'message'       => ($check ? 'Menghapus' : 'Menambah') . ' Video Favorite'
            ]);
        } catch (\Exception $e) {
            return  response()->json([
                'status'    => false,
                'message'   => 'Gagal melakukan poses'
            ]);
        }
    }
}
