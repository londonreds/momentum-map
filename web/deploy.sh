# Uses awscli to copy the content of this directory to the S3 bucket

export S3_BUCKET="indivisibleguide-map"

function gzip_and_s3 () {
    case $1 in
        *.html)
        mimetype="text/html"
        ;;
        *.js)
        mimetype="application/javascript"
        ;;
        *.png)
        mimetype="image/png"
        ;;
        *.css)
        mimetype="text/css"
        ;;
        *.csv)
        mimetype="text/csv"
        ;;
        *.ico)
        mimetype="image/jpeg"
        ;;
        *)
        echo "Skipping $1 because bad file ending"
        return
        ;;
    esac

    gzip -c $1 | aws s3 cp \
        --acl public-read \
        --content-type $mimetype \
        --content-encoding "gzip" \
        - s3://$S3_BUCKET/$1

    if [ $? -eq 0 ]
    then
        echo "Sent ${1} to s3://${S3_BUCKET}/${1}"
    else
        echo "Error saving ${1} to s3://${S3_BUCKET}/${1}" >&2
        exit 1
    fi
}

# HTML
export -f gzip_and_s3
find index.html favicon.ico js img d css -type f -exec bash -c 'gzip_and_s3 "{}"' \;
