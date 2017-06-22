#include <iostream>
#include <sstream>
#include <string>
#include <set>
#include <algorithm>

size_t NumberOfDistinctUniqueWords(std::string&);

int main(int argc, char** argv)
{
	size_t amount;
	std::cout << "Please input your sentence [ENTER - end of the string]: " << std::endl;
	std::string sentence;
	getline(std::cin, sentence);
	amount = NumberOfDistinctUniqueWords(sentence);
	std::cout << "Amount of distinct unique words: " << amount << std::endl;

	system("pause");
	return 0;
}
size_t NumberOfDistinctUniqueWords(std::string& sentence)
{
	transform(sentence.begin(), sentence.end(), sentence.begin(), ::tolower);
	std::set<std::string> unique;
	std::istringstream stream(sentence);
	std::string word;
	while (stream >> word)
	{
		int word_length = word.length();
		int begin = -1, end = word_length;
		while (!isalpha(word[++begin]) && begin < word_length);
		if (begin == word_length)
			continue;
		while (!isalpha(word[--end]));
		auto it_begin = word.begin();
		std::string new_word = { it_begin + begin, it_begin + end + 1 };
		unique.insert(std::move(new_word));
	}
	return unique.size();
}