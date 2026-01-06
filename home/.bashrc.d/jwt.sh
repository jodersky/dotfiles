

# Read a JWT from stdin and decode one of its parts.
# Usage: cat jwt.txt | decode_jwt 1
# $1: part of the JWT to decode (1: header, 2: payload, 3: signature)
decode_jwt() {
    local body=$(cat)
    local payload=$(echo -n "$body" | cut -d '.' -f "$1" | tr '_-' '/+')

    local len=$((${#payload} % 4))
    if [ $len -eq 2 ]; then
        payload="$payload"'=='
    elif [ $len -eq 3 ]; then
        payload="$payload"'='
    fi

    echo "$payload" | base64 -d | jq .
}

alias jwth='decode_jwt 1'
alias jwtp='decode_jwt 2'
alias jwts='decode_jwt 3'
