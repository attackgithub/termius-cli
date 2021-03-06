#!/usr/bin/env bats
load test_helper

@test "init help by arg" {
    run termius init --help
    [ "$status" -eq 0 ]
}

@test "init help command" {
    run termius help init
    [ "$status" -eq 0 ]
}

@test "log into tester account" {
    if [ "$TERMIUS_USERNAME" == '' ] || [ "$TERMIUS_PASSWORD" == '' ];then
        skip '$TERMIUS_USERNAME or $TERMIUS_PASSWORD are not set!'
    fi
    rm ~/.termius/config || true

    run termius init --username $TERMIUS_USERNAME -p $TERMIUS_PASSWORD
    [ "$status" -eq 0 ]
    ! [ -z "$(cat ~/.termius/config)" ]
}

@test "Change tester account" {
    if [ "$TERMIUS_USERNAME" == '' ] || [ "$TERMIUS_PASSWORD" == '' ] ||
        [ "$TERMIUS_USERNAME_2" == '' ] || [ "$TERMIUS_PASSWORD_2" == '' ] ;then
        skip '$TERMIUS_USERNAME or $TERMIUS_PASSWORD or $TERMIUS_USERNAME_2 or $TERMIUS_PASSWORD_2 are not set!'
    fi
    rm ~/.termius/config || true

    termius init --username $TERMIUS_USERNAME -p $TERMIUS_PASSWORD
    populate_storage
    run termius init --username $TERMIUS_USERNAME_2 -p $TERMIUS_PASSWORD_2
    [ "$status" -eq 0 ]
    ! [ -z "$(cat ~/.termius/config)" ]
    assert_clear_storage
}
