class WordListHelper {
  using words_list = std::vector<std::string>;
  using counts_list = std::vector<int>;
 public:
  WordListHelper();
  counts_list counts(const words_list words);
  counts_list vowels(const words_list words);
  counts_list consonants(const words_list words);
 private:
  counts_list map_word(const words_list words, std::function<int(std::string)> functor);
  counts_list map_char(const words_list words, std::function<bool(char)> predicate);
};
