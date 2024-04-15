# -*- coding: utf-8 -*-

from math import exp
import requests


class BaseApiUtils:

    def __init__(self, cfg):
        self.cfg = cfg

    # GLOBAL VALID TYPES
    VALID_MATCH_TYPES = ['exact', 'contains']
    VALID_BODY_TYPES = ['json', 'text']

    # shared requests session object for all sessions
    req_sess = requests.Session()

    def __send_request_without_payload(self, method, url, params):
        if method.lower() == 'get':
            rsp = self.req_sess.get(url=url, params=params)
        elif method.lower() == 'post':
            rsp = self.req_sess.post(url=url, params=params)
        elif method.lower() == 'put':
            rsp = self.req_sess.put(url=url, params=params)
        elif method.lower() == 'patch':
            rsp = self.req_sess.patch(url=url, params=params)
        elif method.lower() == 'delete':
            rsp = self.req_sess.delete(url=url, params=params)
        elif method.lower() == 'head':
            rsp = self.req_sess.head(url=url, params=params)
        elif method.lower() == 'options':
            rsp = self.req_sess.options(url=url, params=params)
        else: # unknown method
            raise AttributeError("unknown method type: '{0}'".format(str(method)))

        return rsp

    def __send_request_with_payload_as_json(self, method, url, payload, params):
        if method.lower() == 'get':
            rsp = self.req_sess.get(url=url, json=payload, params=params)
        elif method.lower() == 'post':
            rsp = self.req_sess.post(url=url, json=payload, params=params)
        elif method.lower() == 'put':
            rsp = self.req_sess.put(url=url, json=payload, params=params)
        elif method.lower() == 'patch':
            rsp = self.req_sess.patch(url=url, json=payload, params=params)
        elif method.lower() == 'delete':
            rsp = self.req_sess.delete(url=url, json=payload, params=params)
        elif method.lower() == 'head':
            rsp = self.req_sess.head(url=url, json=payload, params=params)
        elif method.lower() == 'options':
            rsp = self.req_sess.options(url=url, json=payload, params=params)
        else: # unknown method
            raise AttributeError("unknown method type: '{0}'".format(str(method)))

        return rsp

    def __send_request_with_payload_as_data(self, method, url, payload, params):
        if method.lower() == 'get':
            rsp = self.req_sess.get(url=url, data=payload, params=params)
        elif method.lower() == 'post':
            rsp = self.req_sess.post(url=url, data=payload, params=params)
        elif method.lower() == 'put':
            rsp = self.req_sess.put(url=url, data=payload, params=params)
        elif method.lower() == 'patch':
            rsp = self.req_sess.patch(url=url, data=payload, params=params)
        elif method.lower() == 'delete':
            rsp = self.req_sess.delete(url=url, data=payload, params=params)
        elif method.lower() == 'head':
            rsp = self.req_sess.head(url=url, data=payload, params=params)
        elif method.lower() == 'options':
            rsp = self.req_sess.options(url=url, data=payload, params=params)
        else: # unknown method
            raise AttributeError("unknown method type: '{0}'".format(str(method)))

        return rsp

    def __call_api(self, method, url, payload, params=None, payload_as_json=True):
        if payload is not None:
            if payload_as_json: # send request payload as json
                rsp = self.__send_request_with_payload_as_json(
                    method=method,
                    url=url,
                    payload=payload,
                    params=params
                )
            else: # send request payload as data
                rsp = self.__send_request_with_payload_as_data(
                    method=method,
                    url=url,
                    payload=payload,
                    params=params
                )
        else: # send request without a payload
            rsp = self.__send_request_without_payload(
                method=method,
                url=url,
                params=params
            )

        return rsp

    def check_response_status_code(self, rsp, expected_status_code):
        bool = False
        actual_status_code = rsp.status_code
        bool = (str(actual_status_code) == str(expected_status_code))

        if bool:
            msg = "success"
        else: 
            msg = (
                "for {0} request against url: {1}\n"
                "expected response status code not found\n"
                "  actual status code   : {2}\n"
                "  expected status code : {3}\n"
                "response body/text: {4}".format(
                    str(rsp.request.method),
                    str(rsp.request.url),
                    str(actual_status_code),
                    str(expected_status_code),
                    str(rsp.text)
                )
            )

        return bool, msg

    def check_response_body(self, rsp, expected_body, body_type='json', match_type='exact'):
        bool = False
        try:
            actual_body = rsp.json()
        except Exception as e:
            actual_body = rsp.text
        if match_type.lower() == 'contains':
            bool = (str(expected_body) in str(actual_body))
        elif match_type.lower() == 'exact':
            if body_type.lower() == 'json':
                bool = (expected_body == actual_body)
            elif body_type.lower() == 'text':
                bool = (str(expected_body) == str(actual_body))
            else: # unknown body_type
                raise AttributeError(
                    "unknown body type: '{0}'\n"
                    "valid body types are: '{1}'".format(
                        str(body_type),
                        str(self.VALID_BODY_TYPES)
                    )
                )
        else: # unknown match_type
            raise AttributeError(
                "unknown match type: '{0}'\n"
                "valid match types are: '{1}'".format(
                    str(match_type),
                    str(self.VALID_MATCH_TYPES)
                )
            )
        
        if bool:
            msg = "success"
        else:
            msg = (
                "for {0} request against url: {1}\n"
                "via '{2}' match for {3} type, expected response body not found\n"
                "  actual body   : {4}\n"
                "  expected body : {5}\n".format(
                    str(rsp.request.method),
                    str(rsp.request.url),
                    str(match_type),
                    str(body_type),
                    str(actual_body),
                    str(expected_body)
                )
            )

        return bool, msg

    def check_response_headers(self, rsp, expected_header_key, expected_header_value):
        bool = False
        actual_headers = rsp.headers
        if actual_headers.get(expected_header_key) != None:
            actual_header_value = actual_headers[expected_header_key]
            bool = (str(expected_header_value) in str(actual_header_value))
        
        if bool:
            msg = "success"
        else:
            msg = (
                "for {0} request against url: {1}\n"
                "via 'contains' match, expected response headers not found\n"
                "  actual headers              : {2}\n"
                "  expected header (key:value) : {3}:{4}\n"
                "response body/text: {5}".format(
                    str(rsp.request.method),
                    str(rsp.request.url),
                    str(actual_headers),
                    str(expected_header_key),
                    str(expected_header_value),
                    str(rsp.text)
                )
            )

        return bool, msg
    
    def check_response_content_type(self, rsp, expected_header_value):
        return self.check_response_headers(rsp=rsp, expected_header_key='content-type', expected_header_value=expected_header_value)

    def check_response_allow_methods(self, rsp, expected_header_value):
        return self.check_response_headers(rsp=rsp, expected_header_key='allow', expected_header_value=expected_header_value)

    def delete_it(self, url, params=None):
        rsp = self.__call_api(method='delete', url=url, payload=None, params=params)
        return rsp

    def get_it(self, url, params=None):
        rsp = self.__call_api(method='get', url=url, payload=None, params=params)
        return rsp

    def head_it(self, url, params=None):
        rsp = self.__call_api(method='head', url=url, payload=None, params=params)
        return rsp

    def options_it(self, url, params=None):
        rsp = self.__call_api(method='options', url=url, payload=None, params=params)
        return rsp

    def patch_it(self, url, params=None):
        rsp = self.__call_api(method='patch', url=url, payload=None, params=params)
        return rsp

    def post_it(self, url, params=None):
        rsp = self.__call_api(method='post', url=url, payload=None, params=params)
        return rsp

    def put_it(self, url, params=None):
        rsp = self.__call_api(method='put', url=url, payload=None, params=params)
        return rsp
