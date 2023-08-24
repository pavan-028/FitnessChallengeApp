from cmath import log
from distutils.log import Log
import logging
import uuid
import azure.functions as func

def main(req: func.HttpRequest, doc: func.Out[func.Document]) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    name = req.route_params.get('name')
    start_date=req.route_params.get('startdate')
    end_date=req.route_params.get('enddate')
    guide=req.route_params.get('guide')
    description=req.route_params.get('description')
    part=req.route_params.get('part')


    if not name:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            name = req_body.get('name')
            start_date = req_body.get('startdate')
            log('start_date req body get' + start_date)
            end_date = req_body.get('enddate')

    if name:
        newdocs = func.DocumentList() 
        newproduct_dict = {
            "id": str(uuid.uuid4()),
            "name": name,
            "start_date": start_date,
            "end_date": end_date,
            "guide": guide,
            "description": description,
            "part": part
        }
        
        newdocs.append(func.Document.from_dict(newproduct_dict))
        doc.set(newdocs)
        
        return func.HttpResponse(f"challenge {name} is created")
    else:
        return func.HttpResponse(
             "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response.",
             status_code=200
        )