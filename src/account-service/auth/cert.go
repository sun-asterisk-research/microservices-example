package auth

import (
	"account/config"
	"errors"
	"fmt"
	"os"
)

func GetPrivateKey() ([]byte, error) {
	key, err := os.ReadFile(fmt.Sprintf("%s/id_rsa", config.Values.JWTCertPath))
	if err != nil {
		return []byte{}, errors.New("can not find RSA private key")
	}

	return key, nil
}

func GetPublicKey() ([]byte, error) {
	key, err := os.ReadFile(fmt.Sprintf("%s/id_rsa.pub", config.Values.JWTCertPath))
	if err != nil {
		return []byte{}, errors.New("can not find RSA public key")
	}

	return key, nil
}
