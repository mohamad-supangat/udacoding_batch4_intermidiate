<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    /**
     * Login
     *
     * @return object response
     */
    public function login(Request $request)
    {
        $request->validate([
            'email'         => 'required|email|min:5|max:20',
            'password'      => 'required|min:5|max:20',
        ]);

        $credentials = request(['email', 'password']);
        /* dd($request->remember); */
        if (!auth()->attempt($credentials, $request->remember ? true : false)) {
            return response()->json([
                'status'  => false,
                'message' => 'Username / password yang anda masukan salah',
            ]);
        }

        return response()->json([
            'status' => true,
            'token'  => auth()->user()->createToken('authToken')->accessToken,
            'user'   => auth()->user()
        ]);
    }

    /**
     * fungsi untuk pendaftaran akun user
     *
     * @return object response
     */
    public function register(Request $request)
    {
        $request->validate([
            'name'        => 'required|min:5|max:50',
            'email'       => 'required|min:5|max:50|unique:users,email|email:filter',
            'password'    => 'required|min:5|max:20',
            'confirmation_password' => 'required|min:5|max:25|same:password'
        ]);

        $proses = User::create([
            'username'  => $request->username,
            'name'      => $request->name,
            'email'     => $request->email,
            'password'  => bcrypt($request->password),
        ]);

        return response()->json([
            'status'      => $proses ? true : false,
            'message'     => $proses ? 'Sukes melakukan pendaftaran' : 'Gagal melakukan pendaftaran',
        ]);
    }

    /**
     * Logout
     *
     * @return void
     */
    public function logout()
    {
        auth()->user()->token()->revoke();
        return response()->json([
            'status'    => true,
            'message'   => 'Sukses menghapus sesi login',
        ]);
    }


    /**
     * undocumented function
     *
     * @return void
     */
    public function update_profile(Request $request)
    {
        $request->validate([
            'name'        => 'required|min:5|max:50',
            'email'       => 'required|min:5|max:50|unique:users,email,' . \Auth::id() . '|email:filter',
            'password'              => 'nullable|min:5|max:20',
            'password_confirm'      => 'nullable|min:5|max:20|same:password',
        ]);

        $new_data = [
            'name'        => $request->name,
            'email'       => $request->email,
        ];

        if ($new_password = $request->password) {
            $new_data['password'] = bcrypt($request->password);
        }

        $proses = \Auth::user()->update($new_data);
        return response()->json([
            'status'      => $proses ? true : false,
            'message'     => $proses ? 'Sukes mengupdate profile' : 'Gagal melakukan perubahan',
        ]);
    }
}
