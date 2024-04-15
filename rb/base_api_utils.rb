# encoding: utf-8

module BaseApiUtils

    @@valid_match_types = ['exact', 'contains']
    @@valid_body_types = ['json', 'text']

    def send_request_without_payload(method, url, params)
        begin
            case method.to_s.downcase
            when 'get', 'post', 'put', 'patch', 'delete', 'head', 'options'
                rsp = RestClient::Request.execute(
                    method: :"#{method.to_s.downcase}",
                    url: url,
                    params: params) { |response|
                        case response.code
                        when 301, 302, 307
                            response.follow_redirection
                        else
                            response.return!
                        end # case response block
                } # execute block
            else # unknown value
                raise ArgumentError, "unknown method type: #{method.to_s}"
            end # case method block
        rescue RestClient::ExceptionWithResponse => err
            rsp = err.response
        end # begin
        return rsp
    end
    private :send_request_without_payload

    def send_request_with_payload(method, url, payload, params)
        begin
            case method.to_s.downcase
            when 'get', 'post', 'put', 'patch', 'delete', 'head', 'options'
                rsp = RestClient::Request.execute(
                    method: :"#{method.to_s.downcase}",
                    url: url,
                    payload: payload,
                    params: params) { |response|
                        case response.code
                        when 301, 302, 307
                            response.follow_redirection
                        else
                            response.return!
                        end # case response block
                } # execute block
            else # unknown value
                raise ArgumentError, "unknown method type: #{method.to_s}"
            end # case method block
        rescue RestClient::ExceptionWithResponse => err
            rsp = err.response
        end # begin
        return rsp
    end
    private :send_request_with_payload

    def send_request_with_payload_as_json(method, url, payload, params)
        begin
            case method.to_s.downcase
            when 'delete', 'get', 'head', 'options', 'patch', 'post', 'put'
                rsp = RestClient::Request.execute(
                    method: :"#{method.to_s.downcase}",
                    url: url,
                    payload: payload.to_json,
                    params: params,
                    headers: {content_type: :json}) { |response|
                        case response.code
                        when 301, 302, 307
                            response.follow_redirection
                        else
                            response.return!
                        end # case response block
                } # execute block
            else # unknown value
                raise ArgumentError, "unknown method type: #{method.to_s}"
            end # case method block
        rescue RestClient::ExceptionWithResponse => err
            rsp = err.response
        end # begin
        return rsp
    end
    private :send_request_with_payload_as_json

    def call_api(method, url, payload=nil, params=nil, payload_as_json=true)
        unless payload.nil?
            if payload_as_json # send request payload as a json
                rsp = send_request_with_payload_as_json(
                    method=method,
                    url=url,
                    payload=payload,
                    params=params
                )
            else # send request with payload
                rsp = send_request_with_payload(
                    method=method,
                    url=url,
                    payload=payload,
                    params=params
                )
            end
        else # send request without a payload
            rsp = send_request_without_payload(
                method=method,
                url=url,
                params=params
            )
        end
        return rsp
    end
    private :call_api

    def check_response_status_code(rsp, expected_status_code)
        bool = false
        actual_status_code = rsp.code
        bool = (actual_status_code.to_s == expected_status_code.to_s)

        if bool
            msg = "success"
        else
            msg = "for #{rsp.request.method} request against url: #{rsp.request.url}\n" \
            "expected response status code not found\n" \
            "  actual status code   : #{actual_status_code}\n" \
            "  expected status code : #{expected_status_code}\n" \
            "response body: #{rsp.body}"
        end

        return bool, msg
    end

    def check_response_body(rsp, expected_body, match_type='exact')
        bool = false
        begin
            actual_body = JSON.parse(rsp.body).to_json
        rescue JSON::ParserError
            actual_body = rsp.body
        end
        if match_type.to_s.downcase == 'contains'
            bool = (expected_body.to_s.include? actual_body.to_s)
        elsif match_type.to_s.downcase == 'exact'
            bool = (expected_body.to_s == actual_body.to_s)
        else # unknown match_type
            raise ArgumentError, "unknown match type: #{match_type}\n" \
                                 "valid match types are: #{@@valid_match_types}"
        end

        if bool
            msg = "success"
        else
            msg = "for #{rsp.request.method} request against url: #{rsp.request.url}\n" \
            "via #{match_type} match, expected response body not found\n" \
            "  actual body   : #{actual_body}\n" \
            "  expected body : #{expected_body}\n"
        end

        return bool, msg 
    end

    def check_response_headers(rsp, expected_header_key, expected_header_value)
        bool = false
        actual_headers = rsp.headers
        unless actual_headers[expected_header_key.to_sym].nil?
            actual_header_value = actual_headers[expected_header_key.to_sym]
            bool = (actual_header_value.to_s.include? expected_header_value.to_s)
        end

        if bool
            msg = "success"
        else
            msg = "for #{rsp.request.method} request against url: #{rsp.request.url}\n" \
            "via 'contains' match, expected response headers not found\n" \
            "  actual headers               : #{actual_headers}\n" \
            "  expected headers (key:value) : #{expected_header_key}:#{expected_header_value}\n" \
            "response body: #{rsp.body}"
        end

        return bool, msg 
    end

    def check_response_content_type(rsp, expected_header_value)
        return check_response_headers(rsp=rsp, expected_header_key='content_type', expected_header_value=expected_header_value)
    end

    def check_response_allow_methods(rsp, expected_header_value)
        return check_response_headers(rsp=rsp, expected_header_key='allow', expected_header_value=expected_header_value)
    end

    def delete_it(url, params=nil)
        rsp = call_api(method='delete', url=url, payload=nil, params=params)
        return rsp
    end

    def get_it(url, params=nil)
        rsp = call_api(method='get', url=url, payload=nil, params=params)
        return rsp
    end

    def head_it(url, params=nil)
        rsp = call_api(method='head', url=url, payload=nil, params=params)
        return rsp
    end

    def options_it(url, params=nil)
        rsp = call_api(method='options', url=url, payload=nil, params=params)
        return rsp
    end

    def patch_it(url, params=nil)
        rsp = call_api(method='patch', url=url, payload=nil, params=params)
        return rsp
    end

    def post_it(url, params=nil)
        rsp = call_api(method='post', url=url, payload=nil, params=params)
        return rsp
    end

    def put_it(url, params=nil)
        rsp = call_api(method='put', url=url, payload=nil, params=params)
        return rsp
    end

end # module end
