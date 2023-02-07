package auth

import (
	"account/config"
	"account/db"
	"errors"
	"fmt"
	"time"

	"github.com/golang-jwt/jwt/v4"
)

type JWT struct {
	PrivateKey []byte
	PublicKey  []byte
}

func NewJWT() (JWT, error) {
	privateKey, err := GetPrivateKey()
	if err != nil {
		return JWT{}, err
	}

	publicKey, err := GetPublicKey()
	if err != nil {
		return JWT{}, err
	}

	return JWT{
		PrivateKey: privateKey,
		PublicKey:  publicKey,
	}, nil
}

func (t *JWT) IssueToken(account *db.Account) (string, error) {
	key, err := jwt.ParseRSAPrivateKeyFromPEM(t.PrivateKey)
	if err != nil {
		return "", errors.New("invalid private key")
	}

	now := time.Now()
	claims := &jwt.MapClaims{
		"sub":      fmt.Sprint(account.ID),
		"name":     account.Fullname,
		"username": account.Username,
		"avatar":   account.Avatar,
		"iat":      now.Unix(),
		"exp":      now.AddDate(0, 2, 0).Unix(),
		"aud":      config.Values.JWTAudience,
		"hasura": jwt.MapClaims{
			"x-hasura-allowed-roles": []string{"user", "author"},
			"x-hasura-default-role":  "user",
			"x-hasura-user-id":       fmt.Sprint(account.ID),
		},
	}

	token, err := jwt.NewWithClaims(jwt.SigningMethodRS256, claims).SignedString(key)
	if err != nil {
		return "", errors.New("issue the access token failed")
	}

	return token, nil
}
