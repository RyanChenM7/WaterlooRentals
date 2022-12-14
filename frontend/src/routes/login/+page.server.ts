import { error } from '@sveltejs/kit';
import { BACKEND_FLASK_HOST } from '$env/static/private';
import type { PageServerLoad } from './$types';
import { redirect } from '@sveltejs/kit';


export const load: PageServerLoad = async ({ params, locals }: any) => {
    if (locals.isAuth) {
        throw redirect(307, '/');
    }
}

/** @type {import('./$types').Actions} */
export const actions = {
    login: async ({ cookies, request }: any) => {
        const data = await request.formData();
        const email = data.get('email');
        const password = data.get('password');
        let url = BACKEND_FLASK_HOST + 'login';

        const body = {
            user_or_email : email,
            pass : password
        }
        const header = {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',
            Auth: 'dummyauth'
        }

        const response = await fetch(url, {   
            method:'POST',
            headers: header,
            body: JSON.stringify(body),
            mode: 'cors'
        })
        if (response.ok) {
            let responseData: any = await response.json().then(data => {
                cookies.set('session', data.user[0], {
                    path: '/',
                    httpOnly: true,
                    sameSite: 'lax',
                    maxAge: 60 * 60 * 24 * 30
                });
            });
            throw redirect(307, '/');
        }    
    }
};