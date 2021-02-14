<?php

namespace App\Http\Controllers;

use App\Models\VideoFavorite;
use Illuminate\Http\Request;

class FavoriteVideoController extends Controller
{
    public function list()
    {
        $lists = VideoFavorite::where('user_id', auth()->id())->get();
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
                VideoFavorite::create(array_merge($request->all(), [
                    'user_id'       => auth()->id(),
                ]));
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
