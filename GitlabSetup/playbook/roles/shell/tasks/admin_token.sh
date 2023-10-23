gitlab_host="http://192.168.60.2/gitlab"
gitlab_user="root"
gitlab_password="aaaaaaaa"


body_header=$(curl --retry 300 --retry-delay 5 -L -c cookies.txt -i "${gitlab_host}/users/sign_in" -s)

# grep the auth token for the user login for
#   not sure whether another token on the page will work, too - there are 3 of them
csrf_token=$(echo $body_header | perl -ne 'print "$1\n" if /new_user.*?authenticity_token"[[:blank:]]value="(.+?)"/' | sed -n 1p)

# 2. send login credentials with curl, using cookies and token from previous request
curl -L -b cookies.txt -c cookies.txt -i "${gitlab_host}/users/sign_in" \
	--data "user[login]=${gitlab_user}&user[password]=${gitlab_password}" \
	--data-urlencode "authenticity_token=${csrf_token}"

# 3. send curl GET request to personal access token page to get auth token
body_header=$(curl -L -H 'user-agent: curl' -b cookies.txt -i "${gitlab_host}/-/profile/personal_access_tokens" -s)
csrf_token=$(echo $body_header | perl -ne 'print "$1\n" if /authenticity_token"[[:blank:]]value="(.+?)"/' | sed -n 1p)

# 4. curl POST request to send the "generate personal access token form"
#      the response will be a redirect, so we have to follow using `-L`
body_header=$(curl -L -b cookies.txt "${gitlab_host}/-/profile/personal_access_tokens" \
	--data-urlencode "authenticity_token=${csrf_token}" \
	--data 'personal_access_token[name]=golab-generated&personal_access_token[expires_at]=&personal_access_token[scopes][]=api')

# 5. Scrape the personal access token from the response HTML
personal_access_token=$(echo "$body_header" | sed -n 's/.*created-personal-access-token"[[:blank:]]value="\([^"]*\)".*/\1/p')
echo "$personal_access_token" > admin-access-token.txt



