-- BLOCKS

CREATE TABLE IF NOT EXISTS blocks
(
  slot BIGINT,
  parent_slot BIGINT,
  block_height BIGINT,
  blockhash TEXT,
  previous_blockhash TEXT,
  block_time TIMESTAMP,
  insertion_time TIMESTAMP DEFAULT now(),
  PRIMARY KEY (slot)
);

-- TRANSACTIONS

CREATE TABLE IF NOT EXISTS transactions
(
  slot BIGINT,
  transaction_index BIGINT,
  signature TEXT,
  number_of_signers SMALLINT,
  signer0 TEXT,
  signer1 TEXT DEFAULT '',
  signer2 TEXT DEFAULT '',
  signer3 TEXT DEFAULT '',
  signer4 TEXT DEFAULT '',
  signer5 TEXT DEFAULT '',
  signer6 TEXT DEFAULT '',
  signer7 TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index)
);

CREATE INDEX IF NOT EXISTS idx_signature ON transactions(signature);

-- RAYDIUM AMM EVENTS

CREATE TABLE IF NOT EXISTS raydium_amm_swap_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  amm TEXT,
  "user" TEXT,
  amount_in NUMERIC(42, 21) ,
  amount_out NUMERIC(42, 21) ,
  mint_in TEXT,
  mint_out TEXT,
  direction TEXT,
  pool_pc_amount NUMERIC(42, 21) ,
  pool_coin_amount NUMERIC(42, 21) ,
  user_pre_balance_in NUMERIC(42, 21) ,
  user_pre_balance_out NUMERIC(42, 21) ,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
) PARTITION BY RANGE (slot);

CREATE INDEX IF NOT EXISTS idx_raydium_amm_swap_events_amm ON raydium_amm_swap_events(amm);
CREATE INDEX IF NOT EXISTS idx_raydium_amm_swap_events_user ON raydium_amm_swap_events("user");
CREATE INDEX IF NOT EXISTS idx_raydium_amm_swap_events_mint_in ON raydium_amm_swap_events(mint_in);
CREATE INDEX IF NOT EXISTS idx_raydium_amm_swap_events_mint_out ON raydium_amm_swap_events(mint_out);

CREATE TABLE IF NOT EXISTS raydium_amm_initialize_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  amm TEXT,
  "user" TEXT,
  pc_init_amount NUMERIC(42, 21) ,
  coin_init_amount NUMERIC(42, 21) ,
  lp_init_amount NUMERIC(42, 21) ,
  pc_mint TEXT,
  coin_mint TEXT,
  lp_mint TEXT,
  user_pc_pre_balance NUMERIC(42, 21) ,
  user_coin_pre_balance NUMERIC(42, 21) ,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_raydium_amm_initialize_events_amm ON raydium_amm_initialize_events(amm);
CREATE INDEX IF NOT EXISTS idx_raydium_amm_initialize_events_user ON raydium_amm_initialize_events("user");
CREATE INDEX IF NOT EXISTS idx_raydium_amm_initialize_events_pc_mint ON raydium_amm_initialize_events(pc_mint);
CREATE INDEX IF NOT EXISTS idx_raydium_amm_initialize_events_coin_mint ON raydium_amm_initialize_events(coin_mint);

CREATE TABLE IF NOT EXISTS raydium_amm_deposit_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  amm TEXT,
  "user" TEXT,
  pc_amount NUMERIC(42, 21) ,
  coin_amount NUMERIC(42, 21) ,
  pool_pc_amount NUMERIC(42, 21) ,
  pool_coin_amount NUMERIC(42, 21) ,
  lp_amount NUMERIC(42, 21) ,
  pc_mint TEXT,
  coin_mint TEXT,
  lp_mint TEXT,
  user_pc_pre_balance NUMERIC(42, 21) ,
  user_coin_pre_balance NUMERIC(42, 21) ,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_raydium_amm_deposit_events_amm ON raydium_amm_deposit_events(amm);
CREATE INDEX IF NOT EXISTS idx_raydium_amm_deposit_events_user ON raydium_amm_deposit_events("user");
CREATE INDEX IF NOT EXISTS idx_raydium_amm_deposit_events_pc_mint ON raydium_amm_deposit_events(pc_mint);
CREATE INDEX IF NOT EXISTS idx_raydium_amm_deposit_events_coin_mint ON raydium_amm_deposit_events(coin_mint);

CREATE TABLE IF NOT EXISTS raydium_amm_withdraw_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  amm TEXT,
  "user" TEXT,
  pc_amount NUMERIC(42, 21) ,
  coin_amount NUMERIC(42, 21) ,
  lp_amount NUMERIC(42, 21) ,
  pool_pc_amount NUMERIC(42, 21) ,
  pool_coin_amount NUMERIC(42, 21) ,
  pc_mint TEXT,
  coin_mint TEXT,
  lp_mint TEXT,
  user_pc_pre_balance NUMERIC(42, 21) ,
  user_coin_pre_balance NUMERIC(42, 21) ,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_raydium_amm_withdraw_events_amm ON raydium_amm_withdraw_events(amm);
CREATE INDEX IF NOT EXISTS idx_raydium_amm_withdraw_events_user ON raydium_amm_withdraw_events("user");
CREATE INDEX IF NOT EXISTS idx_raydium_amm_withdraw_events_pc_mint ON raydium_amm_withdraw_events(pc_mint);
CREATE INDEX IF NOT EXISTS idx_raydium_amm_withdraw_events_coin_mint ON raydium_amm_withdraw_events(coin_mint);

CREATE TABLE IF NOT EXISTS raydium_amm_withdraw_pnl_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  amm TEXT,
  "user" TEXT,
  pc_amount NUMERIC(42, 21) ,
  coin_amount NUMERIC(42, 21) ,
  pc_mint TEXT,
  coin_mint TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_raydium_amm_withdraw_pnl_events_amm ON raydium_amm_withdraw_pnl_events(amm);
CREATE INDEX IF NOT EXISTS idx_raydium_amm_withdraw_pnl_events_user ON raydium_amm_withdraw_pnl_events("user");
CREATE INDEX IF NOT EXISTS idx_raydium_amm_withdraw_pnl_events_pc_mint ON raydium_amm_withdraw_pnl_events(pc_mint);
CREATE INDEX IF NOT EXISTS idx_raydium_amm_withdraw_pnl_events_coin_mint ON raydium_amm_withdraw_pnl_events(coin_mint);

-- SPL TOKEN EVENTS

CREATE TABLE IF NOT EXISTS spl_token_initialize_mint_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  mint TEXT,
  decimals BIGINT,
  mint_authority TEXT,
  freeze_authority TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_spl_token_initialize_mint_events_mint ON spl_token_initialize_mint_events(mint);

CREATE TABLE IF NOT EXISTS spl_token_initialize_account_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  account_address TEXT,
  account_owner TEXT,
  mint TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_spl_token_initialize_account_events_account_owner ON spl_token_initialize_account_events(account_owner);
CREATE INDEX IF NOT EXISTS idx_spl_token_initialize_account_events_mint ON spl_token_initialize_account_events(mint);

CREATE TABLE IF NOT EXISTS spl_token_initialize_multisig_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  multisig TEXT,
  m BIGINT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_spl_token_initialize_multisig_events_multisig ON spl_token_initialize_multisig_events(multisig);

CREATE TABLE IF NOT EXISTS spl_token_transfer_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  source_address TEXT,
  source_owner TEXT,
  source_pre_balance NUMERIC(42, 21) ,
  destination_address TEXT,
  destination_owner TEXT,
  destination_pre_balance NUMERIC(42, 21) ,
  mint TEXT,
  amount NUMERIC(42, 21) ,
  authority TEXT,
  transfer_type TEXT DEFAULT 'unknown',
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
) PARTITION BY RANGE (slot);

CREATE INDEX IF NOT EXISTS idx_spl_token_transfer_events_mint ON spl_token_transfer_events(mint);
CREATE INDEX IF NOT EXISTS idx_spl_token_transfer_events_source_owner ON spl_token_transfer_events(source_owner);
CREATE INDEX IF NOT EXISTS idx_spl_token_transfer_events_destination_owner ON spl_token_transfer_events(destination_owner);

CREATE TABLE IF NOT EXISTS spl_token_approve_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  source_address TEXT,
  source_owner TEXT,
  mint TEXT,
  delegate TEXT,
  amount NUMERIC(42, 21) ,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_spl_token_approve_events_mint ON spl_token_approve_events(mint);
CREATE INDEX IF NOT EXISTS idx_spl_token_approve_events_source_owner ON spl_token_approve_events(source_owner);

CREATE TABLE IF NOT EXISTS spl_token_revoke_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  source_address TEXT,
  source_owner TEXT,
  mint TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_spl_token_revoke_events_mint ON spl_token_revoke_events(mint);
CREATE INDEX IF NOT EXISTS idx_spl_token_revoke_events_source_owner ON spl_token_revoke_events(source_owner);

CREATE TABLE IF NOT EXISTS spl_token_set_authority_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  mint TEXT,
  authority_type VARCHAR(14),
  new_authority TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_spl_token_set_authority_events_mint ON spl_token_set_authority_events(mint);

CREATE TABLE IF NOT EXISTS spl_token_mint_to_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  destination_address TEXT,
  destination_owner TEXT,
  destination_pre_balance NUMERIC(42, 21) ,
  mint TEXT,
  mint_authority TEXT,
  amount NUMERIC(42, 21) ,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
) PARTITION BY RANGE (slot);

CREATE INDEX IF NOT EXISTS idx_spl_token_mint_to_events_mint ON spl_token_mint_to_events(mint);
CREATE INDEX IF NOT EXISTS idx_spl_token_mint_to_events_destination_owner ON spl_token_mint_to_events(destination_owner);

CREATE TABLE IF NOT EXISTS spl_token_burn_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  source_address TEXT,
  source_owner TEXT,
  source_pre_balance NUMERIC(42, 21) ,
  mint TEXT,
  authority TEXT,
  amount NUMERIC(42, 21) ,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
) PARTITION BY RANGE (slot);

CREATE INDEX IF NOT EXISTS idx_spl_token_burn_events_mint ON spl_token_burn_events(mint);
CREATE INDEX IF NOT EXISTS idx_spl_token_burn_events_source_owner ON spl_token_burn_events(source_owner);

CREATE TABLE IF NOT EXISTS spl_token_close_account_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  source_address TEXT,
  source_owner TEXT,
  destination TEXT,
  mint TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
) PARTITION BY RANGE (slot);

CREATE INDEX IF NOT EXISTS idx_spl_token_close_account_events_mint ON spl_token_close_account_events(mint);
CREATE INDEX IF NOT EXISTS idx_spl_token_close_account_events_source_owner ON spl_token_close_account_events(source_owner);
CREATE INDEX IF NOT EXISTS idx_spl_token_close_account_events_destination ON spl_token_close_account_events(destination);

CREATE TABLE IF NOT EXISTS spl_token_freeze_account_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  source_address TEXT,
  source_owner TEXT,
  mint TEXT,
  freeze_authority TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_spl_token_freeze_account_events_mint ON spl_token_freeze_account_events(mint);
CREATE INDEX IF NOT EXISTS idx_spl_token_freeze_account_events_source_owner ON spl_token_freeze_account_events(source_owner);

CREATE TABLE IF NOT EXISTS spl_token_thaw_account_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  source_address TEXT,
  source_owner TEXT,
  mint TEXT,
  freeze_authority TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_spl_token_thaw_account_events_mint ON spl_token_thaw_account_events(mint);
CREATE INDEX IF NOT EXISTS idx_spl_token_thaw_account_events_source_owner ON spl_token_thaw_account_events(source_owner);

CREATE TABLE IF NOT EXISTS spl_token_initialize_immutable_owner_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  account_address TEXT,
  account_owner TEXT,
  mint TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
) PARTITION BY RANGE (slot);

CREATE INDEX IF NOT EXISTS idx_spl_token_initialize_immutable_owner_events_account_owner ON spl_token_initialize_immutable_owner_events(account_owner);
CREATE INDEX IF NOT EXISTS idx_spl_token_initialize_immutable_owner_events_mint ON spl_token_initialize_immutable_owner_events(mint);

CREATE TABLE IF NOT EXISTS spl_token_sync_native_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  account_address TEXT,
  account_owner TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_spl_token_sync_native_events_account_owner ON spl_token_sync_native_events(account_owner);

-- SYSTEM PROGRAM EVENTS

CREATE TABLE IF NOT EXISTS system_program_create_account_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  funding_account TEXT,
  new_account TEXT,
  lamports BIGINT,
  space BIGINT,
  owner TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
) PARTITION BY RANGE (slot);

CREATE INDEX IF NOT EXISTS idx_system_program_create_account_events_funding_account ON system_program_create_account_events(funding_account);

CREATE TABLE IF NOT EXISTS system_program_assign_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  assigned_account TEXT,
  owner TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_system_program_assign_events_owner ON system_program_assign_events(owner);

CREATE TABLE IF NOT EXISTS system_program_transfer_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  funding_account TEXT,
  funding_account_pre_balance NUMERIC(42, 21) ,
  funding_account_post_balance NUMERIC(42, 21) ,
  recipient_account TEXT,
  recipient_account_pre_balance NUMERIC(42, 21) ,
  recipient_account_post_balance NUMERIC(42, 21) ,
  lamports BIGINT,
  transfer_type TEXT DEFAULT 'unknown',
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
) PARTITION BY RANGE (slot);

CREATE INDEX IF NOT EXISTS idx_system_program_transfer_events_funding_account ON system_program_transfer_events(funding_account);
CREATE INDEX IF NOT EXISTS idx_system_program_transfer_events_recipient_account ON system_program_transfer_events(recipient_account);

CREATE TABLE IF NOT EXISTS system_program_create_account_with_seed_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  funding_account TEXT,
  created_account TEXT,
  base_account TEXT,
  seed TEXT,
  lamports BIGINT,
  space BIGINT,
  owner TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
) PARTITION BY RANGE (slot);

CREATE INDEX IF NOT EXISTS idx_system_program_create_account_with_seed_events_funding_account ON system_program_create_account_with_seed_events(funding_account);
CREATE INDEX IF NOT EXISTS idx_system_program_create_account_with_seed_events_created_account ON system_program_create_account_with_seed_events(created_account);
CREATE INDEX IF NOT EXISTS idx_system_program_create_account_with_seed_events_base_account ON system_program_create_account_with_seed_events(base_account);

CREATE TABLE IF NOT EXISTS system_program_advance_nonce_account_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  nonce_account TEXT,
  nonce_authority TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_system_program_advance_nonce_account_events_nonce_account ON system_program_advance_nonce_account_events(nonce_account);
CREATE INDEX IF NOT EXISTS idx_system_program_advance_nonce_account_events_nonce_authority ON system_program_advance_nonce_account_events(nonce_authority);

CREATE TABLE IF NOT EXISTS system_program_withdraw_nonce_account_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  nonce_account TEXT,
  nonce_authority TEXT,
  recipient_account TEXT,
  lamports BIGINT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_system_program_withdraw_nonce_account_events_nonce_account ON system_program_withdraw_nonce_account_events(nonce_account);
CREATE INDEX IF NOT EXISTS idx_system_program_withdraw_nonce_account_events_nonce_authority ON system_program_withdraw_nonce_account_events(nonce_authority);
CREATE INDEX IF NOT EXISTS idx_system_program_withdraw_nonce_account_events_recipient_account ON system_program_withdraw_nonce_account_events(recipient_account);

CREATE TABLE IF NOT EXISTS system_program_initialize_nonce_account_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  nonce_account TEXT,
  nonce_authority TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_system_program_initialize_nonce_account_events_nonce_account ON system_program_initialize_nonce_account_events(nonce_account);
CREATE INDEX IF NOT EXISTS idx_system_program_initialize_nonce_account_events_nonce_authority ON system_program_initialize_nonce_account_events(nonce_authority);

CREATE TABLE IF NOT EXISTS system_program_authorize_nonce_account_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  nonce_account TEXT,
  nonce_authority TEXT,
  new_nonce_authority TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_system_program_authorize_nonce_account_events_nonce_account ON system_program_authorize_nonce_account_events(nonce_account);
CREATE INDEX IF NOT EXISTS idx_system_program_authorize_nonce_account_events_nonce_authority ON system_program_authorize_nonce_account_events(nonce_authority);
CREATE INDEX IF NOT EXISTS idx_system_program_authorize_nonce_account_events_new_nonce_authority ON system_program_authorize_nonce_account_events(new_nonce_authority);

CREATE TABLE IF NOT EXISTS system_program_allocate_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  account TEXT,
  space BIGINT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_system_program_allocate_events_account ON system_program_allocate_events(account);

CREATE TABLE IF NOT EXISTS system_program_allocate_with_seed_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  allocated_account TEXT,
  base_account TEXT,
  seed TEXT,
  space BIGINT,
  owner TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_system_program_allocate_with_seed_events_allocated_account ON system_program_allocate_with_seed_events(allocated_account);
CREATE INDEX IF NOT EXISTS idx_system_program_allocate_with_seed_events_base_account ON system_program_allocate_with_seed_events(base_account);

CREATE TABLE IF NOT EXISTS system_program_assign_with_seed_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  assigned_account TEXT,
  base_account TEXT,
  seed TEXT,
  owner TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_system_program_assign_with_seed_events_assigned_account ON system_program_assign_with_seed_events(assigned_account);
CREATE INDEX IF NOT EXISTS idx_system_program_assign_with_seed_events_base_account ON system_program_assign_with_seed_events(base_account);

CREATE TABLE IF NOT EXISTS system_program_transfer_with_seed_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  funding_account TEXT,
  funding_account_pre_balance NUMERIC(42, 21) ,
  funding_account_post_balance NUMERIC(42, 21) ,
  base_account TEXT,
  recipient_account TEXT,
  recipient_account_pre_balance NUMERIC(42, 21) ,
  recipient_account_post_balance NUMERIC(42, 21) ,
  lamports BIGINT,
  from_seed TEXT,
  from_owner TEXT,
  transfer_type TEXT DEFAULT 'unknown',
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_system_program_transfer_with_seed_events_funding_account ON system_program_transfer_with_seed_events(funding_account);
CREATE INDEX IF NOT EXISTS idx_system_program_transfer_with_seed_events_recipient_account ON system_program_transfer_with_seed_events(recipient_account);

CREATE TABLE IF NOT EXISTS system_program_upgrade_nonce_account_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  nonce_account TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_system_program_upgrade_nonce_account_events_nonce_account ON system_program_upgrade_nonce_account_events(nonce_account);

-- PUMP FUN EVENTS

CREATE TABLE IF NOT EXISTS pumpfun_create_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  "user" TEXT,
  name TEXT,
  symbol TEXT,
  uri TEXT,
  mint TEXT,
  bonding_curve TEXT,
  associated_bonding_curve TEXT,
  metadata TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_pumpfun_create_events_user ON pumpfun_create_events("user");
CREATE INDEX IF NOT EXISTS idx_pumpfun_create_events_mint ON pumpfun_create_events(mint);

CREATE TABLE IF NOT EXISTS pumpfun_initialize_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  "user" TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_pumpfun_initialize_events_user ON pumpfun_initialize_events("user");

CREATE TABLE IF NOT EXISTS pumpfun_set_params_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  "user" TEXT,
  fee_recipient TEXT,
  initial_virtual_token_reserves BIGINT,
  initial_virtual_sol_reserves BIGINT,
  initial_real_token_reserves BIGINT,
  token_total_supply BIGINT,
  fee_basis_points BIGINT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_pumpfun_set_params_events_user ON pumpfun_set_params_events("user");
CREATE INDEX IF NOT EXISTS idx_pumpfun_set_params_events_fee_recipient ON pumpfun_set_params_events(fee_recipient);

CREATE TABLE IF NOT EXISTS pumpfun_swap_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  "user" TEXT,
  mint TEXT,
  bonding_curve TEXT,
  token_amount NUMERIC(42, 21) ,
  direction TEXT,
  sol_amount BIGINT,
  virtual_sol_reserves BIGINT,
  virtual_token_reserves BIGINT,
  real_sol_reserves BIGINT,
  real_token_reserves BIGINT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
) PARTITION BY RANGE (slot);

CREATE INDEX IF NOT EXISTS idx_pumpfun_swap_events_user ON pumpfun_swap_events("user");
CREATE INDEX IF NOT EXISTS idx_pumpfun_swap_events_mint ON pumpfun_swap_events(mint);

CREATE TABLE IF NOT EXISTS pumpfun_withdraw_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  mint TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_pumpfun_withdraw_events_mint ON pumpfun_withdraw_events("mint");

-- MPL TOKEN METADATA EVENTS

CREATE TABLE IF NOT EXISTS mpl_token_metadata_create_metadata_account_v3_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  metadata TEXT,
  mint TEXT,
  update_authority TEXT,
  is_mutable BOOLEAN,
  name TEXT,
  symbol TEXT,
  uri TEXT,
  seller_fee_basis_points BIGINT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_mpl_token_metadata_create_metadata_account_v3_events_symbol ON mpl_token_metadata_create_metadata_account_v3_events(symbol);
CREATE INDEX IF NOT EXISTS idx_mpl_token_metadata_create_metadata_account_v3_events_mint ON mpl_token_metadata_create_metadata_account_v3_events(mint);

CREATE TABLE IF NOT EXISTS mpl_token_metadata_other_events
(
  slot BIGINT,
  transaction_index BIGINT,
  instruction_index BIGINT,
  partial_signature TEXT,
  partial_blockhash TEXT,
  "type" TEXT,
  parent_instruction_index BIGINT DEFAULT -1,
  top_instruction_index BIGINT DEFAULT -1,
  parent_instruction_program_id TEXT DEFAULT '',
  top_instruction_program_id TEXT DEFAULT '',
  PRIMARY KEY (slot, transaction_index, instruction_index)
);

CREATE INDEX IF NOT EXISTS idx_mpl_token_metadata_other_events_type ON mpl_token_metadata_other_events("type");

DO $$ 
DECLARE 
  start_slot BIGINT := 0;
  end_slot BIGINT := 1000000;
BEGIN 
  FOR i IN 300..400 LOOP 
    EXECUTE format('
      CREATE TABLE IF NOT EXISTS raydium_amm_swap_events_%s PARTITION OF raydium_amm_swap_events 
      FOR VALUES FROM (%s) TO (%s);', i, start_slot + i * end_slot, start_slot + (i + 1) * end_slot);
    EXECUTE format('
      CREATE TABLE IF NOT EXISTS spl_token_transfer_events_%s PARTITION OF spl_token_transfer_events 
      FOR VALUES FROM (%s) TO (%s);', i, start_slot + i * end_slot, start_slot + (i + 1) * end_slot);
    EXECUTE format('
      CREATE TABLE IF NOT EXISTS spl_token_mint_to_events_%s PARTITION OF spl_token_mint_to_events 
      FOR VALUES FROM (%s) TO (%s);', i, start_slot + i * end_slot, start_slot + (i + 1) * end_slot);
    EXECUTE format('
      CREATE TABLE IF NOT EXISTS spl_token_burn_events_%s PARTITION OF spl_token_burn_events 
      FOR VALUES FROM (%s) TO (%s);', i, start_slot + i * end_slot, start_slot + (i + 1) * end_slot);
    EXECUTE format('
      CREATE TABLE IF NOT EXISTS spl_token_close_account_events_%s PARTITION OF spl_token_close_account_events 
      FOR VALUES FROM (%s) TO (%s);', i, start_slot + i * end_slot, start_slot + (i + 1) * end_slot);
    EXECUTE format('
      CREATE TABLE IF NOT EXISTS spl_token_initialize_immutable_owner_events_%s PARTITION OF spl_token_initialize_immutable_owner_events 
      FOR VALUES FROM (%s) TO (%s);', i, start_slot + i * end_slot, start_slot + (i + 1) * end_slot);
    EXECUTE format('
      CREATE TABLE IF NOT EXISTS system_program_create_account_events_%s PARTITION OF system_program_create_account_events 
      FOR VALUES FROM (%s) TO (%s);', i, start_slot + i * end_slot, start_slot + (i + 1) * end_slot);
    EXECUTE format('
      CREATE TABLE IF NOT EXISTS system_program_transfer_events_%s PARTITION OF system_program_transfer_events 
      FOR VALUES FROM (%s) TO (%s);', i, start_slot + i * end_slot, start_slot + (i + 1) * end_slot);
    EXECUTE format('
      CREATE TABLE IF NOT EXISTS system_program_create_account_with_seed_events_%s PARTITION OF system_program_create_account_with_seed_events 
      FOR VALUES FROM (%s) TO (%s);', i, start_slot + i * end_slot, start_slot + (i + 1) * end_slot);
    EXECUTE format('
      CREATE TABLE IF NOT EXISTS pumpfun_swap_events_%s PARTITION OF pumpfun_swap_events
      FOR VALUES FROM (%s) TO (%s);', i, start_slot + i * end_slot, start_slot + (i + 1) * end_slot);
  END LOOP; 
END $$;