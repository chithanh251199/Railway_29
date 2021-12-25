import java.time.LocalDate;
import java.util.Iterator;
import java.util.jar.Attributes.Name;

import entity.Account;
import entity.Answer;
import entity.CategoryQuestion;
import entity.Department;
import entity.Exam;
import entity.Group;
import entity.Position;
import entity.PositionName;
import entity.Question;
import entity.TypeName;
import entity.TypeQuestion;

public class Main {
	public static void main(String[] args) {
//		Department
		Department department1 = new Department();

		department1.id = 1;
		department1.name = "Phòng DEV";

		Department department2 = new Department();

		department2.id = 2;
		department2.name = "Phòng Kinh Doanh";

		Department department3 = new Department();

		department3.id = 3;
		department3.name = "Phòng Sale";
//		Position

		Position position1 = new Position();

		position1.id = 1;
		position1.name = PositionName.Dev;

		Position position2 = new Position();

		position2.id = 2;
		position2.name = PositionName.Test;

		Position position3 = new Position();

		position3.id = 3;
		position3.name = PositionName.ScrumMaster;

//		Account

		Account account1 = new Account();

		account1.id = 1;
		account1.email = "VTI1@gmail.com";
		account1.username = "AnVTI";
		account1.fullname = "Nguyễn văn An";
		account1.department = department1;
		account1.position = position1;
		account1.createDate = LocalDate.now();

		Account account2 = new Account();

		account2.id = 2;
		account2.email = "VTI2@gmail.com";
		account2.username = "HieuVTI";
		account2.username = "Lê Văn Hiếu";
		account2.department = department2;
		account2.position = position2;
		account2.createDate = LocalDate.of(2021, 03, 17);

		Account account3 = new Account();

		account3.id = 3;
		account3.email = "VTI3@gmail.com";
		account3.username = "ThaoVTI";
		account3.fullname = "Nguyễn Thị Thảo";
		account3.department = department3;
		account3.position = position3;
		account3.createDate = LocalDate.now();

//		Group

		Group group1 = new Group();

		group1.id = 1;
		group1.name = "Testing System";

		Group group2 = new Group();

		group2.id = 2;
		group2.name = "Development";

		Group group3 = new Group();

		group3.id = 3;
		group3.name = "Sale";

		Group[] groupsaccount1 = { group1, group2 };
		account1.groups = groupsaccount1;

		Group[] groupsaccount2 = { group2, group3 };
		account2.groups = groupsaccount2;

		Group[] groupsaccount3 = { group1, group3 };
		account3.groups = groupsaccount3;

		Account[] accountsgroup1 = { account1, account2 };
		group1.accounts = accountsgroup1;

		Account[] accountsgroup2 = { account2, account3 };
		group2.accounts = accountsgroup2;

		Account[] accountsgroup3 = { account1, account3 };
		group3.accounts = accountsgroup3;
//		TypeQuestrion

		TypeQuestion typeQuestion1 = new TypeQuestion();
		typeQuestion1.id = 1;
		typeQuestion1.name = TypeName.Essay;

		TypeQuestion typeQuestion2 = new TypeQuestion();
		typeQuestion1.id = 2;
		typeQuestion1.name = TypeName.Multiple_Choice;

//		CategoryQuestrion

		CategoryQuestion categoryQuestion1 = new CategoryQuestion();
		categoryQuestion1.id = 1;
		categoryQuestion1.name = "JAVA";

		CategoryQuestion categoryQuestion2 = new CategoryQuestion();
		categoryQuestion2.id = 2;
		categoryQuestion2.name = ".NET";

		CategoryQuestion categoryQuestion3 = new CategoryQuestion();
		categoryQuestion3.id = 3;
		categoryQuestion3.name = "SQL";

//		Question

		Question question1 = new Question();
		question1.id = 1;
		question1.content = "Câu hỏi JAVA 1";

		Question question2 = new Question();
		question2.id = 2;
		question2.content = "Câu hỏi JAVA 2";

		Question question3 = new Question();
		question3.id = 3;
		question3.content = "Câu hỏi .NET 1";

		Question question4 = new Question();
		question4.id = 4;
		question4.content = "Câu hỏi .NET 2";

		Question question5 = new Question();
		question5.id = 5;
		question5.content = "Câu hỏi SQL";

//		Answer 

		Answer answer1 = new Answer();
		answer1.id = 1;
		answer1.content = "Câu trả lời JAVA 1";
		answer1.question = question1;
		answer1.isCorrect = true;

		Answer answer2 = new Answer();
		answer2.id = 2;
		answer2.content = "Câu trả lời JAVA 2";
		answer2.question = question2;
		answer2.isCorrect = false;

		Answer answer3 = new Answer();
		answer3.id = 3;
		answer3.content = "Câu trả lời .NET 1";
		answer3.question = question3;
		answer3.isCorrect = false;

		Answer answer4 = new Answer();
		answer4.id = 4;
		answer4.content = "Câu trả lời .NET 2";
		answer4.question = question4;
		answer4.isCorrect = true;

		Answer answer5 = new Answer();
		answer5.id = 5;
		answer5.content = "Câu trả lời SQL";
		answer5.question = question5;
		answer5.isCorrect = true;

//		Exam

		Exam exam1 = new Exam();
		exam1.id = 1;
		exam1.code = 121;
		exam1.title = " Đề thi JAVA 1";
		exam1.categoryQuestion = categoryQuestion1;
		exam1.duration = 90;
		exam1.creator = account1;
		exam1.creaDate = LocalDate.now();

		Exam exam2 = new Exam();
		exam2.id = 2;
		exam2.code = 122;
		exam2.title = " Đề thi JAVA 2";
		exam2.categoryQuestion = categoryQuestion1;
		exam2.duration = 60;
		exam2.creator = account2;
		exam2.creaDate = LocalDate.now();

		Exam exam3 = new Exam();
		exam3.id = 3;
		exam3.code = 123;
		exam3.title = " Đề thi .NET 1";
		exam3.categoryQuestion = categoryQuestion2;
		exam3.duration = 60;
		exam3.creator = account3;
		exam3.creaDate = LocalDate.now();

		Exam exam4 = new Exam();
		exam4.id = 4;
		exam4.code = 124;
		exam4.title = " Đề thi .NET 2";
		exam4.categoryQuestion = categoryQuestion2;
		exam4.duration = 90;
		exam4.creator = account3;
		exam4.creaDate = LocalDate.now();

		Exam exam5 = new Exam();
		exam5.id = 5;
		exam5.code = 125;
		exam5.title = " Đề thi SQL";
		exam5.categoryQuestion = categoryQuestion3;
		exam5.duration = 90;
		exam5.creator = account2;
		exam5.creaDate = LocalDate.now();

		Question[] questionsexam1 = { question1, question2 };
		exam1.questions = questionsexam1;

		Question[] questionsexam2 = { question2, question3 };
		exam2.questions = questionsexam2;

		Question[] questionsexam3 = { question3, question4 };
		exam3.questions = questionsexam3;

		Question[] questionsexam4 = { question1, question5 };
		exam4.questions = questionsexam4;

//		Print Department
		System.out.println("Thông tin phòng ban : " + department1.toString());

//		Print Position
		System.out.println("Thông tin chức vụ : " + position1.toString());

//		Print Account
		System.out.println("Thông tin tài khoản : " + account1.toString());

//		Print Group
		System.out.println("Thông tin nhóm : " + group1.toString());

//		Print TypeQuestion
		System.out.println("Kiểu câu hỏi : " + typeQuestion1.toString());

//		Print CategoryQuestion
		System.out.println("Thể loại câu hỏi : " + categoryQuestion1.toString());

//		Print Question
		System.out.println("Câu hỏi : " + question1.toString());

//		Print Answer
		System.out.println("Câu Trả lời : " + answer1.toString());

//		Print Exam
		System.out.println("Bài thi : " + exam1.toString());

	}
}
