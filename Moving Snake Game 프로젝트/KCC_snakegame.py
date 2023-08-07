# a = [(3,0),(4,0),(5,0),(6,0)]
#
# a = [(2,0)] + a[:-1]
# b = [1,2,3] + [4,5,6]
# print(a)
# print(b)

import pygame

pygame.init() #파이게임을 사용하기 전에 내부적으로 필요한 것들 준비
#색깔 리스트를 만듬
BLACK = (0,0,0)
RED = (255,0,0)
BLUE = (0,0,255)
screen = pygame.display.set_mode([300,300]) #표시될 창의 가로/세로 크기 정함
pygame.display.set_caption('Snake Game') #프로그램 제목 표시줄 입력
running = True #프로그램을 꺼지지 않게 무한 루프에 가둠
screen.fill([255,255,255]) #창을 흰색으로 채움
font = pygame.font.SysFont('arial', 15) #폰트를 정함
text = font.render('Score : 0',True,BLACK) # 텍스트를 입력함

#뱀의 방향 변수 선언(동E,서W,남S,북N)
snake_direction = 'E'

#뱀의 좌표 리스트 / (6,15)이 머리 , (3,15)이 꼬리 / 좌표에 10곱해야함
snake_position = [(6,15),(5,15),(4,15),(3,15)]
clock = pygame.time.Clock()
playing = False

#뱀을 그려주는 함수-> 지금 있는 좌표만의 정보를 이용해서 그려주기만 한다
def draw_snake():
    for position in snake_position:
        # Rect(x좌표, y좌표, 너비, 높이) / 전체가 300칸이라서 x좌표*10, y좌표*10
        snake_rect = pygame.Rect(position[0] * 10, position[1] * 10, 10, 10)
        # 뱀 머리색은 검정~
        if position == snake_position[0]:
            pygame.draw.rect(screen, BLACK, snake_rect)
        else:
            pygame.draw.rect(screen, BLUE, snake_rect)

#머리가 바라보고 있는 기준으로 한칸 더가기
#snake position의 0번째 값이 머리임
def move_snake():
    #바깥쪽에서 선언된 변수를 함수안에서 사용하기 위해서는 global사용해야함
    global snake_position
    if snake_direction == "N":
        snake_position = [(snake_position[0][0],snake_position[0][1]-1)] + snake_position[0:-1]
    elif snake_direction == "S":
        snake_position = [(snake_position[0][0], snake_position[0][1] + 1)] + snake_position[0:-1]
    elif snake_direction == "W":
        snake_position = [(snake_position[0][0] - 1, snake_position[0][1])] + snake_position[0:-1]
    elif snake_direction == "E":
        snake_position = [(snake_position[0][0] + 1, snake_position[0][1])] + snake_position[0:-1]

#키 방향 딕셔너리로 선언하기, 키 실제누르는게 KEY값, VALUE값은 알파벳으로
key_direction = {
    pygame.K_UP: 'N',
    pygame.K_DOWN: 'S',
    pygame.K_LEFT: 'W',
    pygame.K_RIGHT: 'E'
}

while running:
    # 0.1초마다 실행할 수 있도록 해줌
    clock.tick(10)
    screen.fill([255,255,255])
    screen.blit(text,(10,10))
    if playing == True:
        move_snake()
    draw_snake()

    pygame.display.update() #위에서 한 작업을 실제 화면에 표시
    for event in pygame.event.get(): #파이게임 이벤트를 for문으로 실행
        if event.type == pygame.QUIT: #pygame.quit라는 이벤트 있다면 게임 종료
            running = False #running변수가 false면 실행 멈춤
        if event.type == pygame.KEYDOWN:
            if event.key in key_direction:
                snake_direction = key_direction[event.key]
                if playing == False: # 비교 연산자
                    playing = True # 할당


