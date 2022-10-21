import { error } from '@sveltejs/kit';
import { BACKEND_FLASK_HOST } from '$env/static/private';
 
/** @type {import('./$types').LayoutLoad} */
export function load() {
    // do nothing for now
}

/** @type {import('./$types').Actions} */
export const actions = {
    deleteListing: async ({ cookies, request}: any) => {
        console.log("deleteing listing....")
        const data = await request.formData();
        const id = data.get('id');
        console.log("deleteing listing", id)
        let url = BACKEND_FLASK_HOST + 'deleteListing';
        const body = {
            id: id
        }
        const header = {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',
            Auth: 'dummyauth'
        }
        console.log("body", body)
        const response = await fetch(url, {   
                method:'POST',
                headers: header,
                body: JSON.stringify(body),
                mode: 'cors'
            }
        )
        let responseData: any = await response.json().then(data => {
            console.log("data", data)
        });
        return {"message":"done"}
    }
};