
## Introduction

Gringott is key value store written in ruby. I have written this for educational purpose. 
This is inspired by a lot of key value store projects and ideas from them. The objective 
here is to try to use those concepts myself.

# Usage

## Command line

$ gringott-cli
Gringott version 0.1.0
>>

## Exit from the console

$ exit | quit | q

## Create vault

Vault is a where the data is stored, it can be considered as a bucket of key value pairs. On successful execution of 
any write command OK is displayed in the console.
>> create myvault
OK

## Using a vault

On using vault the prompt will change to `valult-name >>`

>> use myvalult
OK
myvault >>

## Delete a vault

>> drop myvault
OK

## List vaults

>> list
myvault

## Set a key

>> set age 20
OK
myvault >>

## Get a key

>> get age
20

## Delete key

myvault >> delete age
OK

## Help

Help command list the available commands and its usages

>> help

create
drop
list
set
get
delete
help
version

## version

Version command shows the verison

>> version
Gringott 0.1.0