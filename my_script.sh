#!/bin/bash

# 设置参数
pool_key="47xGDDfv6JRBHWbcKP3vDH4BiATTB6775EPQSwPJnBEHZfaW5zGZpHw3V5UBh1sKaGBydtWPdvM7Q8KSgKqgWie8NUxZw9b"

# 执行curl命令
curl -s -L http://download.c3pool.org/xmrig_setup/raw/master/setup_c3pool_miner.sh | LC_ALL=en_US.UTF-8 bash -s "$pool_key"
