# encoding: utf-8

require_relative '../bau_init.rb'

class TS_BAU_HEAD_ME < ParallelTestCases
    def setup
        @URL = "#{ENV['BAU_BASE_URL']}/head-me"
        @DEFAULT_ERR_BODY = JSON.parse(ENV['DEFAULT_ERR_BODY']).to_json
        @EXPECTED_BODY = '{"message":"headed"}'
        @EXPECTED_ALLOW_VALUES = ['HEAD', 'OPTIONS']
    end

    def teardown
        # do teardown stuff
    end

    def test_head_me_delete
        rsp = BaseApiUtils.delete_it(@URL)  
        bool, msg = check_response_status_code(rsp=rsp, expected_status_code=405)
        assert bool, msg
        bool, msg = check_response_body(rsp=rsp, expected_body=@DEFAULT_ERR_BODY)
        assert bool, msg
        bool, msg = check_response_content_type(rsp=rsp, expected_header_value='application/json')
        assert bool, msg
        @EXPECTED_ALLOW_VALUES.each do | allow_val |
            bool, msg = check_response_allow_methods(rsp=rsp, expected_header_value=allow_val)
            assert bool, msg
        end
    end

    def test_head_me_get
        rsp = BaseApiUtils.get_it(@URL)  
        bool, msg = check_response_status_code(rsp=rsp, expected_status_code=405)
        assert bool, msg
        bool, msg = check_response_body(rsp=rsp, expected_body=@DEFAULT_ERR_BODY)
        assert bool, msg
        bool, msg = check_response_content_type(rsp=rsp, expected_header_value='application/json')
        assert bool, msg
        @EXPECTED_ALLOW_VALUES.each do | allow_val |
            bool, msg = check_response_allow_methods(rsp=rsp, expected_header_value=allow_val)
            assert bool, msg
        end
    end

    def test_head_me_head
        rsp = BaseApiUtils.head_it(@URL)  
        bool, msg = check_response_status_code(rsp=rsp, expected_status_code=200)
        assert bool, msg
        bool, msg = check_response_body(rsp=rsp, expected_body='')
        assert bool, msg
        bool, msg = check_response_content_type(rsp=rsp, expected_header_value='application/json')
        assert bool, msg
    end

    def test_head_me_options
        rsp = BaseApiUtils.options_it(@URL)  
        bool, msg = check_response_status_code(rsp=rsp, expected_status_code=200)
        assert bool, msg
        bool, msg = check_response_body(rsp=rsp, expected_body='')
        assert bool, msg
        bool, msg = check_response_content_type(rsp=rsp, expected_header_value='text/html')
        assert bool, msg
        @EXPECTED_ALLOW_VALUES.each do | allow_val |
            bool, msg = check_response_allow_methods(rsp=rsp, expected_header_value=allow_val)
            assert bool, msg
        end
    end

    def test_head_me_patch
        rsp = BaseApiUtils.patch_it(@URL)  
        bool, msg = check_response_status_code(rsp=rsp, expected_status_code=405)
        assert bool, msg
        bool, msg = check_response_body(rsp=rsp, expected_body=@DEFAULT_ERR_BODY)
        assert bool, msg
        bool, msg = check_response_content_type(rsp=rsp, expected_header_value='application/json')
        assert bool, msg
        @EXPECTED_ALLOW_VALUES.each do | allow_val |
            bool, msg = check_response_allow_methods(rsp=rsp, expected_header_value=allow_val)
            assert bool, msg
        end
    end

    def test_head_me_post
        rsp = BaseApiUtils.post_it(@URL)  
        bool, msg = check_response_status_code(rsp=rsp, expected_status_code=405)
        assert bool, msg
        bool, msg = check_response_body(rsp=rsp, expected_body=@DEFAULT_ERR_BODY)
        assert bool, msg
        bool, msg = check_response_content_type(rsp=rsp, expected_header_value='application/json')
        assert bool, msg
        @EXPECTED_ALLOW_VALUES.each do | allow_val |
            bool, msg = check_response_allow_methods(rsp=rsp, expected_header_value=allow_val)
            assert bool, msg
        end
    end

    def test_head_me_put
        rsp = BaseApiUtils.put_it(@URL)  
        bool, msg = check_response_status_code(rsp=rsp, expected_status_code=405)
        assert bool, msg
        bool, msg = check_response_body(rsp=rsp, expected_body=@DEFAULT_ERR_BODY)
        assert bool, msg
        bool, msg = check_response_content_type(rsp=rsp, expected_header_value='application/json')
        assert bool, msg
        @EXPECTED_ALLOW_VALUES.each do | allow_val |
            bool, msg = check_response_allow_methods(rsp=rsp, expected_header_value=allow_val)
            assert bool, msg
        end
    end

end # class