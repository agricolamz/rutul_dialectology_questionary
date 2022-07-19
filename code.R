library(tidyverse)
df <- read_csv("/home/agricolamz/work/materials/2022.07.05-27_Rutul/merged_questionaries/moroz_lexicon_numerals_dagloans_MERGED.csv")

df %>% 
  select(domain, question_id, feature_id, feature_title,  stimuli, settlement, speaker_code, raw_data) %>% 
  arrange(settlement, speaker_code, domain, feature_id) %>% 
  mutate(settlement_speaker_code = str_c(settlement, "_", speaker_code)) %>% 
  select(-settlement, -speaker_code) %>% 
  filter(raw_data != "0") %>%
  group_by(domain, question_id, feature_id, feature_title, stimuli) %>% 
  mutate(n_variants = length(unique(raw_data))) %>% 
  pivot_wider(names_from = settlement_speaker_code, values_from = raw_data) %>% 
  write_csv("/home/agricolamz/work/materials/2022.07.05-27_Rutul/merged_questionaries/wide_format.csv", na = "")

expected <- read_csv("/home/agricolamz/work/materials/2022.07.05-27_Rutul/merged_questionaries/expected.csv")

df %>% 
  left_join(expected) %>% 
  arrange(settlement, speaker_code, domain, feature_id) %>% 
  write_csv("/home/agricolamz/work/materials/2022.07.05-27_Rutul/merged_questionaries/moroz_lexicon_numerals_dagloans_MERGED.csv",
            na = "")
